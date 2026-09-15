package cases

import (
	"context"
	"errors"
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
	ProcedureID        int64             `json:"procedureId"`
	ProcedureVersion   int               `json:"procedureVersion"`
	Status             Status            `json:"status"`
	Revision           int64             `json:"revision"`
	Marking            petrunia.Marking  `json:"marking"`
	Net                petrunia.Net      `json:"net"`
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
	GetPublishedProcedure(context.Context, int64) (*catalog.Procedure, error)
}

type transitionCommand struct {
	CaseID           int64
	TransitionID     petrunia.NodeID
	ExpectedRevision int64
	ActorID          int64
	Net              petrunia.Net
	NextMarking      petrunia.Marking
	Completed        bool
}

type repository interface {
	Start(context.Context, int64, int64, *catalog.Procedure) (*Case, error)
	Claim(context.Context, int64, int64) (*Case, error)
	Get(context.Context, int64, int64, bool) (*Case, error)
	ApplyTransition(context.Context, transitionCommand) (*Case, error)
}

type Service struct {
	repo    repository
	catalog ProcedureProvider
}

func NewService(repo repository, provider ProcedureProvider) *Service {
	return &Service{repo: repo, catalog: provider}
}

func (s *Service) Start(ctx context.Context, tramiteID int64, actorID int64) (*Case, error) {
	procedure, err := s.catalog.GetPublishedProcedure(ctx, tramiteID)
	if errors.Is(err, catalog.ErrNoPublishedProcedure) {
		return nil, ErrProcedureInactive
	}
	if err != nil {
		return nil, err
	}
	return s.repo.Start(ctx, tramiteID, actorID, procedure)
}

func (s *Service) Claim(ctx context.Context, caseID, userID int64) (*Case, error) {
	return s.repo.Claim(ctx, caseID, userID)
}

func (s *Service) Get(ctx context.Context, caseID, userID int64, admin bool) (*Case, error) {
	return s.repo.Get(ctx, caseID, userID, admin)
}

func (s *Service) Fire(ctx context.Context, caseID int64, transitionID petrunia.NodeID, expectedRevision, actorID int64) (*Case, error) {
	item, err := s.repo.Get(ctx, caseID, actorID, true)
	if err != nil {
		return nil, err
	}
	var task *Task
	for i := range item.AvailableTasks {
		if item.AvailableTasks[i].TransitionID == transitionID {
			task = &item.AvailableTasks[i]
			break
		}
	}
	if task == nil {
		return nil, ErrConflict
	}
	if !hasParticipant(item.Participants, task.Role, actorID) {
		return nil, ErrForbidden
	}
	if item.Status != StatusActive || item.Revision != expectedRevision {
		return nil, ErrConflict
	}

	next, err := petrunia.Fire(item.Net, item.Marking, transitionID)
	if err != nil {
		return nil, ErrConflict
	}
	return s.repo.ApplyTransition(ctx, transitionCommand{
		CaseID:           caseID,
		TransitionID:     transitionID,
		ExpectedRevision: expectedRevision,
		ActorID:          actorID,
		Net:              item.Net,
		NextMarking:      next,
		Completed:        petrunia.IsFinal(item.Net, next),
	})
}

func hasParticipant(participants []Participant, role petrunia.Role, userID int64) bool {
	for _, participant := range participants {
		if participant.Role == role && participant.UserID == userID {
			return true
		}
	}
	return false
}
