package cases

import (
	"context"
	"database/sql"
	"encoding/json"
	"errors"
	"strings"
	"time"

	"github.com/C-ArenA/Tunkunia/database/sqlc"
	"github.com/C-ArenA/Tunkunia/internal/catalog"
	"github.com/C-ArenA/Tunkunia/petrunia"
)

type sqliteRepository struct {
	db      *sql.DB
	queries *sqlc.Queries
}

func NewSQLiteRepository(db *sql.DB, queries *sqlc.Queries) *sqliteRepository {
	return &sqliteRepository{db: db, queries: queries}
}

var _ repository = (*sqliteRepository)(nil)

func (s *sqliteRepository) Start(ctx context.Context, tramiteID int64, actorID int64, version *catalog.ProcedureVersion) (*Case, error) {
	marking := petrunia.InitialMarking(version.Definition)
	markingJSON, _ := json.Marshal(marking)
	tx, err := s.db.BeginTx(ctx, nil)
	if err != nil {
		return nil, err
	}
	defer tx.Rollback()
	result, err := tx.ExecContext(ctx, `INSERT INTO cases (tramite_id, procedure_version_id, marking, initiated_by) VALUES (?, ?, ?, ?)`, tramiteID, version.ID, string(markingJSON), actorID)
	if err != nil {
		return nil, err
	}
	caseID, err := result.LastInsertId()
	if err != nil {
		return nil, err
	}
	if _, err := tx.ExecContext(ctx, `INSERT INTO case_participants (case_id, role, user_id) VALUES (?, 'citizen', ?)`, caseID, actorID); err != nil {
		return nil, err
	}
	if err := reconcileTasks(ctx, tx, caseID, version.Definition, marking); err != nil {
		return nil, err
	}
	if err := tx.Commit(); err != nil {
		return nil, err
	}
	return s.Get(ctx, caseID, actorID, false)
}

func (s *sqliteRepository) ListMine(ctx context.Context, userID int64) ([]Summary, error) {
	rows, err := s.queries.ListCaseSummariesByUser(ctx, s.db, userID)
	if err != nil {
		return nil, err
	}
	result := make([]Summary, len(rows))
	for i, row := range rows {
		result[i] = Summary{ID: row.ID, TramiteID: row.TramiteID, TramiteName: row.TramiteName, Status: Status(row.Status), Revision: row.Revision, StartedAt: parseTime(row.StartedAt), UpdatedAt: parseTime(row.UpdatedAt)}
	}
	return result, nil
}

func (s *sqliteRepository) ListUnassigned(ctx context.Context) ([]Summary, error) {
	rows, err := s.queries.ListUnassignedCaseSummaries(ctx, s.db)
	if err != nil {
		return nil, err
	}
	result := make([]Summary, len(rows))
	for i, row := range rows {
		result[i] = Summary{ID: row.ID, TramiteID: row.TramiteID, TramiteName: row.TramiteName, Status: Status(row.Status), Revision: row.Revision, StartedAt: parseTime(row.StartedAt), UpdatedAt: parseTime(row.UpdatedAt)}
	}
	return result, nil
}

func (s *sqliteRepository) Claim(ctx context.Context, caseID, userID int64) (*Case, error) {
	tx, err := s.db.BeginTx(ctx, nil)
	if err != nil {
		return nil, err
	}
	defer tx.Rollback()
	var claimable int
	err = tx.QueryRowContext(ctx, `SELECT EXISTS(
		SELECT 1 FROM cases c JOIN case_tasks ct ON ct.case_id=c.id
		WHERE c.id=? AND c.status='active' AND ct.role='servant' AND ct.status='pending')`, caseID).Scan(&claimable)
	if err != nil {
		return nil, err
	}
	if claimable == 0 {
		return nil, ErrNotClaimable
	}
	_, err = tx.ExecContext(ctx, `INSERT INTO case_participants(case_id, role, user_id) VALUES (?, 'servant', ?)`, caseID, userID)
	if err != nil {
		if isConstraint(err) {
			return nil, ErrAlreadyClaimed
		}
		return nil, err
	}
	if _, err := tx.ExecContext(ctx, `UPDATE case_tasks SET assignee_id=? WHERE case_id=? AND role='servant' AND status='pending'`, userID, caseID); err != nil {
		return nil, err
	}
	if err := notifyPending(ctx, tx, caseID, petrunia.RoleServant, userID); err != nil {
		return nil, err
	}
	if err := tx.Commit(); err != nil {
		return nil, err
	}
	return s.Get(ctx, caseID, userID, false)
}

func (s *sqliteRepository) Get(ctx context.Context, caseID, userID int64, admin bool) (*Case, error) {
	if !admin {
		var allowed int
		if err := s.db.QueryRowContext(ctx, `SELECT EXISTS(SELECT 1 FROM case_participants WHERE case_id=? AND user_id=?)`, caseID, userID).Scan(&allowed); err != nil {
			return nil, err
		}
		if allowed == 0 {
			return nil, ErrNotFound
		}
	}
	return loadCase(ctx, s.db, caseID, userID, admin)
}

func (s *sqliteRepository) ApplyTransition(ctx context.Context, command transitionCommand) (*Case, error) {
	tx, err := s.db.BeginTx(ctx, nil)
	if err != nil {
		return nil, err
	}
	defer tx.Rollback()
	var revision int64
	var status, markingText string
	err = tx.QueryRowContext(ctx, `SELECT revision, status, marking FROM cases WHERE id=?`, command.CaseID).Scan(&revision, &status, &markingText)
	if errors.Is(err, sql.ErrNoRows) {
		return nil, ErrNotFound
	}
	if err != nil {
		return nil, err
	}
	if status != string(StatusActive) || revision != command.ExpectedRevision {
		return nil, ErrConflict
	}
	var taskID int64
	var label, role string
	err = tx.QueryRowContext(ctx, `SELECT id, transition_label, role FROM case_tasks WHERE case_id=? AND transition_id=? AND status='pending'`, command.CaseID, command.TransitionID).Scan(&taskID, &label, &role)
	if errors.Is(err, sql.ErrNoRows) {
		return nil, ErrConflict
	}
	if err != nil {
		return nil, err
	}
	var assigned int
	if err := tx.QueryRowContext(ctx, `SELECT EXISTS(SELECT 1 FROM case_participants WHERE case_id=? AND role=? AND user_id=?)`, command.CaseID, role, command.ActorID).Scan(&assigned); err != nil {
		return nil, err
	}
	if assigned == 0 {
		return nil, ErrForbidden
	}
	afterJSON, _ := json.Marshal(command.NextMarking)
	nextStatus := StatusActive
	completedAt := any(nil)
	if command.Completed {
		nextStatus = StatusCompleted
		completedAt = time.Now().UTC()
	}
	result, err := tx.ExecContext(ctx, `UPDATE cases SET marking=?, status=?, revision=revision+1, updated_at=CURRENT_TIMESTAMP, completed_at=? WHERE id=? AND revision=?`, string(afterJSON), nextStatus, completedAt, command.CaseID, command.ExpectedRevision)
	if err != nil {
		return nil, err
	}
	if rows, _ := result.RowsAffected(); rows != 1 {
		return nil, ErrConflict
	}
	if _, err := tx.ExecContext(ctx, `UPDATE case_tasks SET status='completed', finished_at=CURRENT_TIMESTAMP WHERE id=?`, taskID); err != nil {
		return nil, err
	}
	if _, err := tx.ExecContext(ctx, `INSERT INTO case_actions(case_id, task_id, transition_id, transition_label, actor_id, revision_before, marking_before, marking_after) VALUES(?,?,?,?,?,?,?,?)`, command.CaseID, taskID, command.TransitionID, label, command.ActorID, revision, markingText, string(afterJSON)); err != nil {
		return nil, err
	}
	if nextStatus == StatusCompleted {
		if _, err := tx.ExecContext(ctx, `UPDATE case_tasks SET status='cancelled', finished_at=CURRENT_TIMESTAMP WHERE case_id=? AND status='pending'`, command.CaseID); err != nil {
			return nil, err
		}
	} else if err := reconcileTasks(ctx, tx, command.CaseID, command.Definition, command.NextMarking); err != nil {
		return nil, err
	}
	if err := tx.Commit(); err != nil {
		return nil, err
	}
	return s.Get(ctx, command.CaseID, command.ActorID, false)
}

func (s *sqliteRepository) ListTasks(ctx context.Context, userID int64, status TaskStatus) ([]Task, error) {
	rows, err := s.queries.ListTasksByAssignee(ctx, s.db, sqlc.ListTasksByAssigneeParams{AssigneeID: sql.NullInt64{Int64: userID, Valid: true}, Status: string(status)})
	if err != nil {
		return nil, err
	}
	var result []Task
	for _, row := range rows {
		task := Task{ID: row.ID, CaseID: row.CaseID, TransitionID: petrunia.NodeID(row.TransitionID), TransitionLabel: row.TransitionLabel, Role: petrunia.Role(row.Role), Status: TaskStatus(row.Status), CreatedAt: parseTime(row.CreatedAt)}
		if row.AssigneeID.Valid {
			task.AssigneeID = &row.AssigneeID.Int64
		}
		result = append(result, task)
	}
	return result, nil
}

func (s *sqliteRepository) ListNotifications(ctx context.Context, userID int64) ([]Notification, error) {
	rows, err := s.queries.ListNotificationsByUser(ctx, s.db, userID)
	if err != nil {
		return nil, err
	}
	var result []Notification
	for _, row := range rows {
		item := Notification{ID: row.ID, CaseID: row.CaseID, TaskID: row.TaskID, Type: row.Type, Title: row.Title, CreatedAt: parseTime(row.CreatedAt)}
		if row.ReadAt.Valid {
			t := parseTime(row.ReadAt.String)
			item.ReadAt = &t
		}
		result = append(result, item)
	}
	return result, nil
}

func (s *sqliteRepository) MarkNotificationRead(ctx context.Context, notificationID, userID int64) error {
	rows, err := s.queries.MarkNotificationRead(ctx, s.db, sqlc.MarkNotificationReadParams{ID: notificationID, UserID: userID})
	if err != nil {
		return err
	}
	if rows == 0 {
		return ErrNotFound
	}
	return nil
}

func reconcileTasks(ctx context.Context, tx *sql.Tx, caseID int64, net petrunia.Net, marking petrunia.Marking) error {
	wanted := map[petrunia.NodeID]petrunia.Transition{}
	for _, transition := range petrunia.EnabledTransitions(net, marking) {
		wanted[transition.ID] = transition
	}
	rows, err := tx.QueryContext(ctx, `SELECT id, transition_id FROM case_tasks WHERE case_id=? AND status='pending'`, caseID)
	if err != nil {
		return err
	}
	existing := map[petrunia.NodeID]int64{}
	for rows.Next() {
		var id int64
		var transitionID petrunia.NodeID
		if err := rows.Scan(&id, &transitionID); err != nil {
			rows.Close()
			return err
		}
		existing[transitionID] = id
	}
	rows.Close()
	for transitionID, taskID := range existing {
		if _, ok := wanted[transitionID]; !ok {
			if _, err := tx.ExecContext(ctx, `UPDATE case_tasks SET status='cancelled', finished_at=CURRENT_TIMESTAMP WHERE id=?`, taskID); err != nil {
				return err
			}
		}
	}
	for transitionID, transition := range wanted {
		if _, ok := existing[transitionID]; ok {
			continue
		}
		var assignee sql.NullInt64
		err := tx.QueryRowContext(ctx, `SELECT user_id FROM case_participants WHERE case_id=? AND role=?`, caseID, transition.Role).Scan(&assignee)
		if errors.Is(err, sql.ErrNoRows) {
			assignee = sql.NullInt64{}
		} else if err != nil {
			return err
		}
		result, err := tx.ExecContext(ctx, `INSERT INTO case_tasks(case_id, transition_id, transition_label, role, assignee_id) VALUES(?,?,?,?,?)`, caseID, transitionID, transition.Label, transition.Role, assignee)
		if err != nil {
			return err
		}
		if assignee.Valid {
			taskID, _ := result.LastInsertId()
			if err := insertNotification(ctx, tx, assignee.Int64, caseID, taskID, transition.Label); err != nil {
				return err
			}
		}
	}
	return nil
}

func notifyPending(ctx context.Context, tx *sql.Tx, caseID int64, role petrunia.Role, userID int64) error {
	rows, err := tx.QueryContext(ctx, `SELECT id, transition_label FROM case_tasks WHERE case_id=? AND role=? AND status='pending'`, caseID, role)
	if err != nil {
		return err
	}
	defer rows.Close()
	for rows.Next() {
		var taskID int64
		var label string
		if err := rows.Scan(&taskID, &label); err != nil {
			return err
		}
		if err := insertNotification(ctx, tx, userID, caseID, taskID, label); err != nil {
			return err
		}
	}
	return rows.Err()
}

func insertNotification(ctx context.Context, tx *sql.Tx, userID, caseID, taskID int64, label string) error {
	_, err := tx.ExecContext(ctx, `INSERT INTO notifications(user_id, case_id, task_id, type, title) VALUES(?,?,?,'action_enabled',?) ON CONFLICT(user_id,task_id,type) DO NOTHING`, userID, caseID, taskID, "Acción disponible: "+label)
	return err
}

func loadCase(ctx context.Context, db *sql.DB, caseID, viewerID int64, admin bool) (*Case, error) {
	var item Case
	var markingText, definitionText, started, updated string
	var completed sql.NullString
	err := db.QueryRowContext(ctx, `SELECT c.id,c.tramite_id,t.name,c.procedure_version_id,pv.version_number,c.status,c.revision,c.marking,pv.definition,c.started_at,c.updated_at,c.completed_at FROM cases c JOIN tramites t ON t.id=c.tramite_id JOIN procedure_versions pv ON pv.id=c.procedure_version_id WHERE c.id=?`, caseID).Scan(&item.ID, &item.TramiteID, &item.TramiteName, &item.ProcedureVersionID, &item.ProcedureVersion, &item.Status, &item.Revision, &markingText, &definitionText, &started, &updated, &completed)
	if errors.Is(err, sql.ErrNoRows) {
		return nil, ErrNotFound
	}
	if err != nil {
		return nil, err
	}
	if err := json.Unmarshal([]byte(markingText), &item.Marking); err != nil {
		return nil, err
	}
	if err := json.Unmarshal([]byte(definitionText), &item.Definition); err != nil {
		return nil, err
	}
	item.StartedAt = parseTime(started)
	item.UpdatedAt = parseTime(updated)
	if completed.Valid {
		t := parseTime(completed.String)
		item.CompletedAt = &t
	}
	for _, transition := range petrunia.EnabledTransitions(item.Definition, item.Marking) {
		item.EnabledTransitions = append(item.EnabledTransitions, transition.ID)
	}
	rows, err := db.QueryContext(ctx, `SELECT cp.role,cp.user_id,u.name,cp.assigned_at FROM case_participants cp JOIN users u ON u.id=cp.user_id WHERE cp.case_id=? ORDER BY cp.role`, caseID)
	if err != nil {
		return nil, err
	}
	for rows.Next() {
		var p Participant
		var at string
		if err := rows.Scan(&p.Role, &p.UserID, &p.Name, &at); err != nil {
			rows.Close()
			return nil, err
		}
		p.AssignedAt = parseTime(at)
		item.Participants = append(item.Participants, p)
	}
	rows.Close()
	taskQuery := `SELECT id,case_id,transition_id,transition_label,role,assignee_id,status,created_at FROM case_tasks WHERE case_id=? AND status='pending'`
	taskArgs := []any{caseID}
	if !admin {
		taskQuery += ` AND assignee_id=?`
		taskArgs = append(taskArgs, viewerID)
	}
	taskQuery += ` ORDER BY id`
	rows, err = db.QueryContext(ctx, taskQuery, taskArgs...)
	if err != nil {
		return nil, err
	}
	for rows.Next() {
		var task Task
		var assignee sql.NullInt64
		var at string
		if err := rows.Scan(&task.ID, &task.CaseID, &task.TransitionID, &task.TransitionLabel, &task.Role, &assignee, &task.Status, &at); err != nil {
			rows.Close()
			return nil, err
		}
		if assignee.Valid {
			task.AssigneeID = &assignee.Int64
		}
		task.CreatedAt = parseTime(at)
		item.AvailableTasks = append(item.AvailableTasks, task)
	}
	rows.Close()
	rows, err = db.QueryContext(ctx, `SELECT ca.id,ca.transition_id,ca.transition_label,ca.actor_id,u.name,ca.occurred_at FROM case_actions ca JOIN users u ON u.id=ca.actor_id WHERE ca.case_id=? ORDER BY ca.id`, caseID)
	if err != nil {
		return nil, err
	}
	for rows.Next() {
		var action Action
		var at string
		if err := rows.Scan(&action.ID, &action.TransitionID, &action.TransitionLabel, &action.ActorID, &action.ActorName, &at); err != nil {
			rows.Close()
			return nil, err
		}
		action.OccurredAt = parseTime(at)
		item.History = append(item.History, action)
	}
	rows.Close()
	return &item, nil
}

func parseTime(value string) time.Time {
	for _, layout := range []string{time.RFC3339Nano, time.DateTime, "2006-01-02T15:04:05Z"} {
		if parsed, err := time.Parse(layout, value); err == nil {
			return parsed.UTC()
		}
	}
	return time.Time{}
}

func isConstraint(err error) bool {
	return err != nil && (strings.Contains(strings.ToLower(err.Error()), "constraint") || strings.Contains(err.Error(), "UNIQUE"))
}
