package cases

import (
	"context"
	"errors"

	"github.com/C-ArenA/Tunkunia/internal/api/v1/oapi"
	"github.com/C-ArenA/Tunkunia/internal/authn"
	"github.com/C-ArenA/Tunkunia/internal/catalog"
	"github.com/C-ArenA/Tunkunia/internal/user"
	"github.com/C-ArenA/Tunkunia/petrunia"
)

type StrictCasesHandlerV1 struct {
	service *Service
	users   *user.Service
}

func NewStrictCasesHandlerV1(service *Service, users *user.Service) *StrictCasesHandlerV1 {
	return &StrictCasesHandlerV1{service: service, users: users}
}

func (h *StrictCasesHandlerV1) principal(ctx context.Context) (*authn.Principal, bool) {
	return authn.FromAuthContext(ctx)
}

func (h *StrictCasesHandlerV1) isAdmin(ctx context.Context) bool {
	p, ok := h.principal(ctx)
	return ok && p.Type == authn.UserPrincipal && h.users.IsAdmin(ctx, user.UserId(p.ID))
}

func (h *StrictCasesHandlerV1) isPublicServant(ctx context.Context) bool {
	p, ok := h.principal(ctx)
	return ok && p.Type == authn.UserPrincipal && h.users.IsPublicServant(ctx, user.UserId(p.ID))
}

func (h *StrictCasesHandlerV1) StartCase(ctx context.Context, request oapi.StartCaseRequestObject) (oapi.StartCaseResponseObject, error) {
	p, ok := h.principal(ctx)
	if !ok {
		return nil, authn.ErrRequiresAuthenticatedUser
	}
	item, err := h.service.Start(ctx, int64(request.Id), int64(p.ID))
	if err != nil {
		return oapi.StartCase409ApplicationProblemPlusJSONResponse{ConflictApplicationProblemPlusJSONResponse: oapi.NewConflictResponse(err.Error())}, nil
	}
	return oapi.StartCase201JSONResponse(caseToResponse(*item)), nil
}

func (h *StrictCasesHandlerV1) ListCases(ctx context.Context, request oapi.ListCasesRequestObject) (oapi.ListCasesResponseObject, error) {
	p, ok := h.principal(ctx)
	if !ok {
		return nil, authn.ErrRequiresAuthenticatedUser
	}
	var items []Summary
	var err error
	if string(request.Params.Scope) == "unassigned" {
		if !h.isPublicServant(ctx) {
			return oapi.ListCases403ApplicationProblemPlusJSONResponse{ForbiddenApplicationProblemPlusJSONResponse: oapi.NewForbiddenResponse("se requiere ser servidor público")}, nil
		}
		items, err = h.service.ListUnassigned(ctx)
	} else {
		items, err = h.service.ListMine(ctx, int64(p.ID))
	}
	if err != nil {
		return nil, err
	}
	result := make(oapi.ListCases200JSONResponse, len(items))
	for i, item := range items {
		result[i] = summaryToResponse(item)
	}
	return result, nil
}

func (h *StrictCasesHandlerV1) GetCase(ctx context.Context, request oapi.GetCaseRequestObject) (oapi.GetCaseResponseObject, error) {
	p, ok := h.principal(ctx)
	if !ok {
		return nil, authn.ErrRequiresAuthenticatedUser
	}
	item, err := h.service.Get(ctx, int64(request.Id), int64(p.ID), h.isAdmin(ctx))
	if err != nil {
		return oapi.GetCase404ApplicationProblemPlusJSONResponse{NotFoundApplicationProblemPlusJSONResponse: oapi.NewNotFoundResponse(err.Error())}, nil
	}
	return oapi.GetCase200JSONResponse(caseToResponse(*item)), nil
}

func (h *StrictCasesHandlerV1) ClaimCase(ctx context.Context, request oapi.ClaimCaseRequestObject) (oapi.ClaimCaseResponseObject, error) {
	p, ok := h.principal(ctx)
	if !ok {
		return nil, authn.ErrRequiresAuthenticatedUser
	}
	if !h.isPublicServant(ctx) {
		return oapi.ClaimCase403ApplicationProblemPlusJSONResponse{ForbiddenApplicationProblemPlusJSONResponse: oapi.NewForbiddenResponse("se requiere ser servidor público")}, nil
	}
	item, err := h.service.Claim(ctx, int64(request.Id), int64(p.ID))
	if err != nil {
		return oapi.ClaimCase409ApplicationProblemPlusJSONResponse{ConflictApplicationProblemPlusJSONResponse: oapi.NewConflictResponse(err.Error())}, nil
	}
	return oapi.ClaimCase200JSONResponse(caseToResponse(*item)), nil
}

func (h *StrictCasesHandlerV1) FireTransition(ctx context.Context, request oapi.FireTransitionRequestObject) (oapi.FireTransitionResponseObject, error) {
	p, ok := h.principal(ctx)
	if !ok {
		return nil, authn.ErrRequiresAuthenticatedUser
	}
	item, err := h.service.Fire(ctx, int64(request.Id), petrunia.NodeID(request.TransitionId), request.Body.ExpectedRevision, int64(p.ID))
	if errors.Is(err, ErrForbidden) {
		return oapi.FireTransition403ApplicationProblemPlusJSONResponse{ForbiddenApplicationProblemPlusJSONResponse: oapi.NewForbiddenResponse(err.Error())}, nil
	}
	if err != nil {
		return oapi.FireTransition409ApplicationProblemPlusJSONResponse{ConflictApplicationProblemPlusJSONResponse: oapi.NewConflictResponse(err.Error())}, nil
	}
	return oapi.FireTransition200JSONResponse(caseToResponse(*item)), nil
}

func (h *StrictCasesHandlerV1) ListTasks(ctx context.Context, request oapi.ListTasksRequestObject) (oapi.ListTasksResponseObject, error) {
	p, ok := h.principal(ctx)
	if !ok {
		return nil, authn.ErrRequiresAuthenticatedUser
	}
	status := TaskPending
	if request.Params.Status != nil && string(*request.Params.Status) == "completed" {
		status = TaskCompleted
	}
	items, err := h.service.ListTasks(ctx, int64(p.ID), status)
	if err != nil {
		return nil, err
	}
	result := make(oapi.ListTasks200JSONResponse, len(items))
	for i, item := range items {
		result[i] = taskToResponse(item)
	}
	return result, nil
}

func (h *StrictCasesHandlerV1) ListNotifications(ctx context.Context, _ oapi.ListNotificationsRequestObject) (oapi.ListNotificationsResponseObject, error) {
	p, ok := h.principal(ctx)
	if !ok {
		return nil, authn.ErrRequiresAuthenticatedUser
	}
	items, err := h.service.ListNotifications(ctx, int64(p.ID))
	if err != nil {
		return nil, err
	}
	result := make(oapi.ListNotifications200JSONResponse, len(items))
	for i, item := range items {
		result[i] = notificationToResponse(item)
	}
	return result, nil
}

func (h *StrictCasesHandlerV1) MarkNotificationRead(ctx context.Context, request oapi.MarkNotificationReadRequestObject) (oapi.MarkNotificationReadResponseObject, error) {
	p, ok := h.principal(ctx)
	if !ok {
		return nil, authn.ErrRequiresAuthenticatedUser
	}
	if err := h.service.MarkNotificationRead(ctx, request.Id, int64(p.ID)); err != nil {
		return oapi.MarkNotificationRead404ApplicationProblemPlusJSONResponse{NotFoundApplicationProblemPlusJSONResponse: oapi.NewNotFoundResponse(err.Error())}, nil
	}
	return oapi.MarkNotificationRead204Response{}, nil
}

func summaryToResponse(v Summary) oapi.CaseSummary {
	return oapi.CaseSummary{Id: v.ID, TramiteId: v.TramiteID, TramiteName: v.TramiteName, Status: oapi.CaseSummaryStatus(v.Status), Revision: v.Revision, StartedAt: v.StartedAt, UpdatedAt: v.UpdatedAt}
}

func caseToResponse(v Case) oapi.Case {
	marking := map[string]int{}
	for id, n := range v.Marking {
		marking[string(id)] = int(n)
	}
	result := oapi.Case{Id: v.ID, TramiteId: v.TramiteID, TramiteName: v.TramiteName, ProcedureVersionId: v.ProcedureVersionID, ProcedureVersion: v.ProcedureVersion, Status: oapi.CaseStatus(v.Status), Revision: v.Revision, Marking: marking, Definition: catalog.ProcedureToResponse(v.Definition), StartedAt: v.StartedAt, UpdatedAt: v.UpdatedAt, CompletedAt: v.CompletedAt}
	for _, id := range v.EnabledTransitions {
		result.EnabledTransitions = append(result.EnabledTransitions, string(id))
	}
	for _, p := range v.Participants {
		result.Participants = append(result.Participants, oapi.Participant{Role: oapi.ProcedureRole(p.Role), UserId: p.UserID, Name: p.Name, AssignedAt: p.AssignedAt})
	}
	for _, t := range v.AvailableTasks {
		result.AvailableTasks = append(result.AvailableTasks, taskToResponse(t))
	}
	for _, a := range v.History {
		result.History = append(result.History, oapi.CaseAction{Id: a.ID, TransitionId: string(a.TransitionID), TransitionLabel: a.TransitionLabel, ActorId: a.ActorID, ActorName: a.ActorName, OccurredAt: a.OccurredAt})
	}
	return result
}

func taskToResponse(v Task) oapi.Task {
	return oapi.Task{Id: v.ID, CaseId: v.CaseID, TransitionId: string(v.TransitionID), TransitionLabel: v.TransitionLabel, Role: oapi.ProcedureRole(v.Role), AssigneeId: v.AssigneeID, Status: oapi.TaskStatus(v.Status), CreatedAt: v.CreatedAt}
}

func notificationToResponse(v Notification) oapi.Notification {
	return oapi.Notification{Id: v.ID, CaseId: v.CaseID, TaskId: v.TaskID, Type: oapi.NotificationType(v.Type), Title: v.Title, CreatedAt: v.CreatedAt, ReadAt: v.ReadAt}
}
