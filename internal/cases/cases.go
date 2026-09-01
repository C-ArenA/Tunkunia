package cases

import (
	"context"
	"database/sql"
	"encoding/json"
	"errors"
	"strings"
	"time"

	"github.com/C-ArenA/Tunkunia/internal/catalog"
	"github.com/C-ArenA/Tunkunia/petrunia"
)

var (
	ErrNotFound          = errors.New("caso no encontrado")
	ErrForbidden         = errors.New("acción no autorizada")
	ErrConflict          = errors.New("el caso fue modificado por otra operación")
	ErrAlreadyClaimed    = errors.New("el caso ya tiene servidor asignado")
	ErrNotClaimable      = errors.New("el caso no requiere actualmente un servidor")
	ErrProcedureInactive = errors.New("el trámite no está publicado")
)

type Status string
type TaskStatus string

const (
	StatusActive    Status     = "active"
	StatusCompleted Status     = "completed"
	TaskPending     TaskStatus = "pending"
	TaskCompleted   TaskStatus = "completed"
	TaskCancelled   TaskStatus = "cancelled"
)

type Participant struct {
	Role       petrunia.Role `json:"role"`
	UserID     int64         `json:"userId"`
	Name       string        `json:"name"`
	AssignedAt time.Time     `json:"assignedAt"`
}

type Task struct {
	ID              int64           `json:"id"`
	CaseID          int64           `json:"caseId"`
	TransitionID    petrunia.NodeID `json:"transitionId"`
	TransitionLabel string          `json:"transitionLabel"`
	Role            petrunia.Role   `json:"role"`
	AssigneeID      *int64          `json:"assigneeId,omitempty"`
	Status          TaskStatus      `json:"status"`
	CreatedAt       time.Time       `json:"createdAt"`
}

type Action struct {
	ID              int64           `json:"id"`
	TransitionID    petrunia.NodeID `json:"transitionId"`
	TransitionLabel string          `json:"transitionLabel"`
	ActorID         int64           `json:"actorId"`
	ActorName       string          `json:"actorName"`
	OccurredAt      time.Time       `json:"occurredAt"`
}

type Case struct {
	ID                 int64             `json:"id"`
	TramiteID          int64             `json:"tramiteId"`
	TramiteName        string            `json:"tramiteName"`
	ProcedureVersionID int64             `json:"procedureVersionId"`
	ProcedureVersion   int               `json:"procedureVersion"`
	Status             Status            `json:"status"`
	Revision           int64             `json:"revision"`
	Marking            petrunia.Marking  `json:"marking"`
	Definition         petrunia.Net      `json:"definition"`
	Participants       []Participant     `json:"participants"`
	EnabledTransitions []petrunia.NodeID `json:"enabledTransitions"`
	AvailableTasks     []Task            `json:"availableTasks"`
	History            []Action          `json:"history"`
	StartedAt          time.Time         `json:"startedAt"`
	UpdatedAt          time.Time         `json:"updatedAt"`
	CompletedAt        *time.Time        `json:"completedAt,omitempty"`
}

type Summary struct {
	ID          int64     `json:"id"`
	TramiteID   int64     `json:"tramiteId"`
	TramiteName string    `json:"tramiteName"`
	Status      Status    `json:"status"`
	Revision    int64     `json:"revision"`
	StartedAt   time.Time `json:"startedAt"`
	UpdatedAt   time.Time `json:"updatedAt"`
}

type Notification struct {
	ID        int64      `json:"id"`
	CaseID    int64      `json:"caseId"`
	TaskID    int64      `json:"taskId"`
	Type      string     `json:"type"`
	Title     string     `json:"title"`
	CreatedAt time.Time  `json:"createdAt"`
	ReadAt    *time.Time `json:"readAt,omitempty"`
}

type ProcedureProvider interface {
	GetPublishedProcedure(context.Context, catalog.TramiteID) (*catalog.ProcedureVersion, error)
}

type Service struct {
	db      *sql.DB
	catalog ProcedureProvider
}

func NewService(db *sql.DB, provider ProcedureProvider) *Service {
	return &Service{db: db, catalog: provider}
}

func (s *Service) Start(ctx context.Context, tramiteID int64, actorID int64) (*Case, error) {
	version, err := s.catalog.GetPublishedProcedure(ctx, catalog.TramiteID(tramiteID))
	if errors.Is(err, catalog.ErrNoPublishedProcedure) {
		return nil, ErrProcedureInactive
	}
	if err != nil {
		return nil, err
	}
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

func (s *Service) ListMine(ctx context.Context, userID int64) ([]Summary, error) {
	return listSummaries(ctx, s.db, `
		SELECT c.id, c.tramite_id, t.name, c.status, c.revision, c.started_at, c.updated_at
		FROM cases c JOIN tramites t ON t.id=c.tramite_id
		JOIN case_participants cp ON cp.case_id=c.id
		WHERE cp.user_id=? ORDER BY c.updated_at DESC`, userID)
}

func (s *Service) ListUnassigned(ctx context.Context) ([]Summary, error) {
	return listSummaries(ctx, s.db, `
		SELECT DISTINCT c.id, c.tramite_id, t.name, c.status, c.revision, c.started_at, c.updated_at
		FROM cases c JOIN tramites t ON t.id=c.tramite_id
		JOIN case_tasks ct ON ct.case_id=c.id AND ct.role='servant' AND ct.status='pending'
		LEFT JOIN case_participants cp ON cp.case_id=c.id AND cp.role='servant'
		WHERE c.status='active' AND cp.user_id IS NULL ORDER BY c.started_at`, nil)
}

func (s *Service) Claim(ctx context.Context, caseID, userID int64) (*Case, error) {
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

func (s *Service) Get(ctx context.Context, caseID, userID int64, admin bool) (*Case, error) {
	if !admin {
		var allowed int
		if err := s.db.QueryRowContext(ctx, `SELECT EXISTS(SELECT 1 FROM case_participants WHERE case_id=? AND user_id=?)`, caseID, userID).Scan(&allowed); err != nil {
			return nil, err
		}
		if allowed == 0 {
			return nil, ErrNotFound
		}
	}
	return loadCase(ctx, s.db, caseID, userID)
}

func (s *Service) Fire(ctx context.Context, caseID int64, transitionID petrunia.NodeID, expectedRevision, actorID int64) (*Case, error) {
	tx, err := s.db.BeginTx(ctx, nil)
	if err != nil {
		return nil, err
	}
	defer tx.Rollback()
	var revision int64
	var status, markingText, definitionText string
	err = tx.QueryRowContext(ctx, `SELECT c.revision, c.status, c.marking, pv.definition FROM cases c JOIN procedure_versions pv ON pv.id=c.procedure_version_id WHERE c.id=?`, caseID).Scan(&revision, &status, &markingText, &definitionText)
	if errors.Is(err, sql.ErrNoRows) {
		return nil, ErrNotFound
	}
	if err != nil {
		return nil, err
	}
	if status != string(StatusActive) || revision != expectedRevision {
		return nil, ErrConflict
	}
	var net petrunia.Net
	var marking petrunia.Marking
	if err := json.Unmarshal([]byte(definitionText), &net); err != nil {
		return nil, err
	}
	if err := json.Unmarshal([]byte(markingText), &marking); err != nil {
		return nil, err
	}
	var taskID int64
	var label, role string
	err = tx.QueryRowContext(ctx, `SELECT id, transition_label, role FROM case_tasks WHERE case_id=? AND transition_id=? AND status='pending'`, caseID, transitionID).Scan(&taskID, &label, &role)
	if errors.Is(err, sql.ErrNoRows) {
		return nil, ErrConflict
	}
	if err != nil {
		return nil, err
	}
	var assigned int
	if err := tx.QueryRowContext(ctx, `SELECT EXISTS(SELECT 1 FROM case_participants WHERE case_id=? AND role=? AND user_id=?)`, caseID, role, actorID).Scan(&assigned); err != nil {
		return nil, err
	}
	if assigned == 0 {
		return nil, ErrForbidden
	}
	next, err := petrunia.Fire(net, marking, transitionID)
	if err != nil {
		return nil, ErrConflict
	}
	beforeJSON, _ := json.Marshal(marking)
	afterJSON, _ := json.Marshal(next)
	nextStatus := StatusActive
	completedAt := any(nil)
	if petrunia.IsFinal(net, next) {
		nextStatus = StatusCompleted
		completedAt = time.Now().UTC()
	}
	result, err := tx.ExecContext(ctx, `UPDATE cases SET marking=?, status=?, revision=revision+1, updated_at=CURRENT_TIMESTAMP, completed_at=? WHERE id=? AND revision=?`, string(afterJSON), nextStatus, completedAt, caseID, expectedRevision)
	if err != nil {
		return nil, err
	}
	if rows, _ := result.RowsAffected(); rows != 1 {
		return nil, ErrConflict
	}
	if _, err := tx.ExecContext(ctx, `UPDATE case_tasks SET status='completed', finished_at=CURRENT_TIMESTAMP WHERE id=?`, taskID); err != nil {
		return nil, err
	}
	if _, err := tx.ExecContext(ctx, `INSERT INTO case_actions(case_id, task_id, transition_id, transition_label, actor_id, revision_before, marking_before, marking_after) VALUES(?,?,?,?,?,?,?,?)`, caseID, taskID, transitionID, label, actorID, revision, string(beforeJSON), string(afterJSON)); err != nil {
		return nil, err
	}
	if nextStatus == StatusCompleted {
		if _, err := tx.ExecContext(ctx, `UPDATE case_tasks SET status='cancelled', finished_at=CURRENT_TIMESTAMP WHERE case_id=? AND status='pending'`, caseID); err != nil {
			return nil, err
		}
	} else if err := reconcileTasks(ctx, tx, caseID, net, next); err != nil {
		return nil, err
	}
	if err := tx.Commit(); err != nil {
		return nil, err
	}
	return s.Get(ctx, caseID, actorID, false)
}

func (s *Service) ListTasks(ctx context.Context, userID int64, status TaskStatus) ([]Task, error) {
	rows, err := s.db.QueryContext(ctx, `SELECT id, case_id, transition_id, transition_label, role, assignee_id, status, created_at FROM case_tasks WHERE assignee_id=? AND status=? ORDER BY created_at DESC`, userID, status)
	if err != nil {
		return nil, err
	}
	defer rows.Close()
	var result []Task
	for rows.Next() {
		var task Task
		var assignee sql.NullInt64
		var created string
		if err := rows.Scan(&task.ID, &task.CaseID, &task.TransitionID, &task.TransitionLabel, &task.Role, &assignee, &task.Status, &created); err != nil {
			return nil, err
		}
		if assignee.Valid {
			task.AssigneeID = &assignee.Int64
		}
		task.CreatedAt = parseTime(created)
		result = append(result, task)
	}
	return result, rows.Err()
}

func (s *Service) ListNotifications(ctx context.Context, userID int64) ([]Notification, error) {
	rows, err := s.db.QueryContext(ctx, `SELECT id, case_id, task_id, type, title, created_at, read_at FROM notifications WHERE user_id=? ORDER BY created_at DESC`, userID)
	if err != nil {
		return nil, err
	}
	defer rows.Close()
	var result []Notification
	for rows.Next() {
		var item Notification
		var created string
		var read sql.NullString
		if err := rows.Scan(&item.ID, &item.CaseID, &item.TaskID, &item.Type, &item.Title, &created, &read); err != nil {
			return nil, err
		}
		item.CreatedAt = parseTime(created)
		if read.Valid {
			t := parseTime(read.String)
			item.ReadAt = &t
		}
		result = append(result, item)
	}
	return result, rows.Err()
}

func (s *Service) MarkNotificationRead(ctx context.Context, notificationID, userID int64) error {
	result, err := s.db.ExecContext(ctx, `UPDATE notifications SET read_at=COALESCE(read_at,CURRENT_TIMESTAMP) WHERE id=? AND user_id=?`, notificationID, userID)
	if err != nil {
		return err
	}
	if rows, _ := result.RowsAffected(); rows == 0 {
		return ErrNotFound
	}
	return nil
}

func reconcileTasks(ctx context.Context, tx *sql.Tx, caseID int64, net petrunia.Net, marking petrunia.Marking) error {
	enabled := petrunia.EnabledTransitions(net, marking)
	wanted := map[petrunia.NodeID]petrunia.Transition{}
	for _, transition := range enabled {
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

func loadCase(ctx context.Context, db *sql.DB, caseID, viewerID int64) (*Case, error) {
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
	rows, err = db.QueryContext(ctx, `SELECT id,case_id,transition_id,transition_label,role,assignee_id,status,created_at FROM case_tasks WHERE case_id=? AND assignee_id=? AND status='pending' ORDER BY id`, caseID, viewerID)
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
		var a Action
		var at string
		if err := rows.Scan(&a.ID, &a.TransitionID, &a.TransitionLabel, &a.ActorID, &a.ActorName, &at); err != nil {
			rows.Close()
			return nil, err
		}
		a.OccurredAt = parseTime(at)
		item.History = append(item.History, a)
	}
	rows.Close()
	return &item, nil
}

func listSummaries(ctx context.Context, db *sql.DB, query string, arg any) ([]Summary, error) {
	var rows *sql.Rows
	var err error
	if arg == nil {
		rows, err = db.QueryContext(ctx, query)
	} else {
		rows, err = db.QueryContext(ctx, query, arg)
	}
	if err != nil {
		return nil, err
	}
	defer rows.Close()
	var result []Summary
	for rows.Next() {
		var item Summary
		var started, updated string
		if err := rows.Scan(&item.ID, &item.TramiteID, &item.TramiteName, &item.Status, &item.Revision, &started, &updated); err != nil {
			return nil, err
		}
		item.StartedAt = parseTime(started)
		item.UpdatedAt = parseTime(updated)
		result = append(result, item)
	}
	return result, rows.Err()
}

func parseTime(value string) time.Time {
	for _, layout := range []string{time.RFC3339Nano, "2006-01-02 15:04:05", "2006-01-02T15:04:05Z"} {
		if parsed, err := time.Parse(layout, value); err == nil {
			return parsed.UTC()
		}
	}
	return time.Time{}
}

func isConstraint(err error) bool {
	return err != nil && (strings.Contains(strings.ToLower(err.Error()), "constraint") || strings.Contains(err.Error(), "UNIQUE"))
}
