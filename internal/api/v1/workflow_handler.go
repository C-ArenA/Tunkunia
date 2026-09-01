package v1

import (
	"context"
	"database/sql"
	"errors"

	"github.com/C-ArenA/Tunkunia/internal/api/v1/oapi"
	"github.com/C-ArenA/Tunkunia/internal/authn"
	"github.com/C-ArenA/Tunkunia/internal/cases"
	"github.com/C-ArenA/Tunkunia/internal/catalog"
	"github.com/C-ArenA/Tunkunia/internal/user"
	"github.com/C-ArenA/Tunkunia/petrunia"
	openapi_types "github.com/oapi-codegen/runtime/types"
)

type WorkflowHandler struct {
	catalog *catalog.Service
	cases   *cases.Service
	users   *user.Service
}

func NewWorkflowHandler(catalogService *catalog.Service, caseService *cases.Service, userService *user.Service) *WorkflowHandler {
	return &WorkflowHandler{catalog: catalogService, cases: caseService, users: userService}
}

func (h *WorkflowHandler) principal(ctx context.Context) (*authn.Principal, bool) {
	return authn.FromAuthContext(ctx)
}

func (h *WorkflowHandler) hasRole(ctx context.Context, role user.RoleName) bool {
	p, ok := h.principal(ctx)
	return ok && p.Type == authn.UserPrincipal && h.users.HasRole(ctx, user.UserId(p.ID), role)
}

func (h *WorkflowHandler) GetPublishedProcedure(ctx context.Context, request oapi.GetPublishedProcedureRequestObject) (oapi.GetPublishedProcedureResponseObject, error) {
	version, err := h.catalog.GetPublishedProcedure(ctx, catalog.TramiteID(request.Id))
	if err != nil {
		return oapi.GetPublishedProcedure404ApplicationProblemPlusJSONResponse{NotFoundApplicationProblemPlusJSONResponse: oapi.NewNotFoundResponse(err.Error())}, nil
	}
	return oapi.GetPublishedProcedure200JSONResponse{ProcedureVersionJSONResponse: oapi.ProcedureVersionJSONResponse(procedureVersionToAPI(*version))}, nil
}

func (h *WorkflowHandler) GetDraftProcedure(ctx context.Context, request oapi.GetDraftProcedureRequestObject) (oapi.GetDraftProcedureResponseObject, error) {
	if !h.hasRole(ctx, user.ADMIN) {
		return oapi.GetDraftProcedure403ApplicationProblemPlusJSONResponse{ForbiddenApplicationProblemPlusJSONResponse: oapi.NewForbiddenResponse("se requiere administración")}, nil
	}
	version, err := h.catalog.GetDraftProcedure(ctx, catalog.TramiteID(request.Id))
	if err != nil {
		return oapi.GetDraftProcedure404ApplicationProblemPlusJSONResponse{NotFoundApplicationProblemPlusJSONResponse: oapi.NewNotFoundResponse(err.Error())}, nil
	}
	return oapi.GetDraftProcedure200JSONResponse{ProcedureVersionJSONResponse: oapi.ProcedureVersionJSONResponse(procedureVersionToAPI(*version))}, nil
}

func (h *WorkflowHandler) SaveDraftProcedure(ctx context.Context, request oapi.SaveDraftProcedureRequestObject) (oapi.SaveDraftProcedureResponseObject, error) {
	if !h.hasRole(ctx, user.ADMIN) {
		return oapi.SaveDraftProcedure403ApplicationProblemPlusJSONResponse{ForbiddenApplicationProblemPlusJSONResponse: oapi.NewForbiddenResponse("se requiere administración")}, nil
	}
	version, err := h.catalog.SaveDraftProcedure(ctx, catalog.TramiteID(request.Id), procedureFromAPI(*request.Body))
	if err != nil {
		return oapi.SaveDraftProcedure404ApplicationProblemPlusJSONResponse{NotFoundApplicationProblemPlusJSONResponse: oapi.NewNotFoundResponse(err.Error())}, nil
	}
	return oapi.SaveDraftProcedure200JSONResponse{ProcedureVersionJSONResponse: oapi.ProcedureVersionJSONResponse(procedureVersionToAPI(*version))}, nil
}

func (h *WorkflowHandler) PublishProcedure(ctx context.Context, request oapi.PublishProcedureRequestObject) (oapi.PublishProcedureResponseObject, error) {
	if !h.hasRole(ctx, user.ADMIN) {
		return oapi.PublishProcedure403ApplicationProblemPlusJSONResponse{ForbiddenApplicationProblemPlusJSONResponse: oapi.NewForbiddenResponse("se requiere administración")}, nil
	}
	version, err := h.catalog.PublishProcedure(ctx, catalog.TramiteID(request.Id))
	var validation *catalog.ProcedureValidationError
	if errors.As(err, &validation) {
		violations := make([]oapi.ProcedureViolation, len(validation.Violations))
		for i, v := range validation.Violations {
			violations[i] = oapi.ProcedureViolation{Code: v.Code, Message: v.Message}
		}
		return oapi.PublishProcedure422JSONResponse{Violations: violations}, nil
	}
	if err != nil {
		return oapi.PublishProcedure404ApplicationProblemPlusJSONResponse{NotFoundApplicationProblemPlusJSONResponse: oapi.NewNotFoundResponse(err.Error())}, nil
	}
	return oapi.PublishProcedure200JSONResponse{ProcedureVersionJSONResponse: oapi.ProcedureVersionJSONResponse(procedureVersionToAPI(*version))}, nil
}

func (h *WorkflowHandler) ArchiveTramite(ctx context.Context, request oapi.ArchiveTramiteRequestObject) (oapi.ArchiveTramiteResponseObject, error) {
	if !h.hasRole(ctx, user.ADMIN) {
		return oapi.ArchiveTramite403ApplicationProblemPlusJSONResponse{ForbiddenApplicationProblemPlusJSONResponse: oapi.NewForbiddenResponse("se requiere administración")}, nil
	}
	if err := h.catalog.Archive(ctx, catalog.TramiteID(request.Id)); err != nil {
		return oapi.ArchiveTramite404ApplicationProblemPlusJSONResponse{NotFoundApplicationProblemPlusJSONResponse: oapi.NewNotFoundResponse(err.Error())}, nil
	}
	return oapi.ArchiveTramite204Response{}, nil
}

func (h *WorkflowHandler) StartCase(ctx context.Context, request oapi.StartCaseRequestObject) (oapi.StartCaseResponseObject, error) {
	p, ok := h.principal(ctx)
	if !ok {
		return nil, errRequiresAuthenticatedUser
	}
	item, err := h.cases.Start(ctx, int64(request.Id), int64(p.ID))
	if err != nil {
		return oapi.StartCase409ApplicationProblemPlusJSONResponse{ConflictApplicationProblemPlusJSONResponse: oapi.NewConflictResponse(err.Error())}, nil
	}
	return oapi.StartCase201JSONResponse(caseToAPI(*item)), nil
}

func (h *WorkflowHandler) ListCases(ctx context.Context, request oapi.ListCasesRequestObject) (oapi.ListCasesResponseObject, error) {
	p, ok := h.principal(ctx)
	if !ok {
		return nil, errRequiresAuthenticatedUser
	}
	var items []cases.Summary
	var err error
	if string(request.Params.Scope) == "unassigned" {
		if !h.hasRole(ctx, user.SERVANT) {
			return oapi.ListCases403ApplicationProblemPlusJSONResponse{ForbiddenApplicationProblemPlusJSONResponse: oapi.NewForbiddenResponse("se requiere el rol servant")}, nil
		}
		items, err = h.cases.ListUnassigned(ctx)
	} else {
		items, err = h.cases.ListMine(ctx, int64(p.ID))
	}
	if err != nil {
		return nil, err
	}
	result := make(oapi.ListCases200JSONResponse, len(items))
	for i, item := range items {
		result[i] = summaryToAPI(item)
	}
	return result, nil
}

func (h *WorkflowHandler) GetCase(ctx context.Context, request oapi.GetCaseRequestObject) (oapi.GetCaseResponseObject, error) {
	p, ok := h.principal(ctx)
	if !ok {
		return nil, errRequiresAuthenticatedUser
	}
	item, err := h.cases.Get(ctx, int64(request.Id), int64(p.ID), h.hasRole(ctx, user.ADMIN))
	if err != nil {
		return oapi.GetCase404ApplicationProblemPlusJSONResponse{NotFoundApplicationProblemPlusJSONResponse: oapi.NewNotFoundResponse(err.Error())}, nil
	}
	return oapi.GetCase200JSONResponse(caseToAPI(*item)), nil
}

func (h *WorkflowHandler) ClaimCase(ctx context.Context, request oapi.ClaimCaseRequestObject) (oapi.ClaimCaseResponseObject, error) {
	p, ok := h.principal(ctx)
	if !ok {
		return nil, errRequiresAuthenticatedUser
	}
	if !h.hasRole(ctx, user.SERVANT) {
		return oapi.ClaimCase403ApplicationProblemPlusJSONResponse{ForbiddenApplicationProblemPlusJSONResponse: oapi.NewForbiddenResponse("se requiere el rol servant")}, nil
	}
	item, err := h.cases.Claim(ctx, int64(request.Id), int64(p.ID))
	if err != nil {
		return oapi.ClaimCase409ApplicationProblemPlusJSONResponse{ConflictApplicationProblemPlusJSONResponse: oapi.NewConflictResponse(err.Error())}, nil
	}
	return oapi.ClaimCase200JSONResponse(caseToAPI(*item)), nil
}

func (h *WorkflowHandler) FireTransition(ctx context.Context, request oapi.FireTransitionRequestObject) (oapi.FireTransitionResponseObject, error) {
	p, ok := h.principal(ctx)
	if !ok {
		return nil, errRequiresAuthenticatedUser
	}
	item, err := h.cases.Fire(ctx, int64(request.Id), petrunia.NodeID(request.TransitionId), request.Body.ExpectedRevision, int64(p.ID))
	if errors.Is(err, cases.ErrForbidden) {
		return oapi.FireTransition403ApplicationProblemPlusJSONResponse{ForbiddenApplicationProblemPlusJSONResponse: oapi.NewForbiddenResponse(err.Error())}, nil
	}
	if err != nil {
		return oapi.FireTransition409ApplicationProblemPlusJSONResponse{ConflictApplicationProblemPlusJSONResponse: oapi.NewConflictResponse(err.Error())}, nil
	}
	return oapi.FireTransition200JSONResponse(caseToAPI(*item)), nil
}

func (h *WorkflowHandler) ListTasks(ctx context.Context, request oapi.ListTasksRequestObject) (oapi.ListTasksResponseObject, error) {
	p, ok := h.principal(ctx)
	if !ok {
		return nil, errRequiresAuthenticatedUser
	}
	status := cases.TaskPending
	if request.Params.Status != nil && string(*request.Params.Status) == "completed" {
		status = cases.TaskCompleted
	}
	items, err := h.cases.ListTasks(ctx, int64(p.ID), status)
	if err != nil {
		return nil, err
	}
	result := make(oapi.ListTasks200JSONResponse, len(items))
	for i, item := range items {
		result[i] = taskToAPI(item)
	}
	return result, nil
}
func (h *WorkflowHandler) ListNotifications(ctx context.Context, _ oapi.ListNotificationsRequestObject) (oapi.ListNotificationsResponseObject, error) {
	p, ok := h.principal(ctx)
	if !ok {
		return nil, errRequiresAuthenticatedUser
	}
	items, err := h.cases.ListNotifications(ctx, int64(p.ID))
	if err != nil {
		return nil, err
	}
	result := make(oapi.ListNotifications200JSONResponse, len(items))
	for i, item := range items {
		result[i] = notificationToAPI(item)
	}
	return result, nil
}
func (h *WorkflowHandler) MarkNotificationRead(ctx context.Context, request oapi.MarkNotificationReadRequestObject) (oapi.MarkNotificationReadResponseObject, error) {
	p, ok := h.principal(ctx)
	if !ok {
		return nil, errRequiresAuthenticatedUser
	}
	if err := h.cases.MarkNotificationRead(ctx, request.Id, int64(p.ID)); err != nil {
		return oapi.MarkNotificationRead404ApplicationProblemPlusJSONResponse{NotFoundApplicationProblemPlusJSONResponse: oapi.NewNotFoundResponse(err.Error())}, nil
	}
	return oapi.MarkNotificationRead204Response{}, nil
}

func (h *WorkflowHandler) ListUsers(ctx context.Context, _ oapi.ListUsersRequestObject) (oapi.ListUsersResponseObject, error) {
	if !h.hasRole(ctx, user.ADMIN) {
		return oapi.ListUsers403ApplicationProblemPlusJSONResponse{ForbiddenApplicationProblemPlusJSONResponse: oapi.NewForbiddenResponse("se requiere administración")}, nil
	}
	items, err := h.users.ListUsers(ctx)
	if err != nil {
		return nil, err
	}
	result := make(oapi.ListUsers200JSONResponse, len(items))
	for i, item := range items {
		result[i] = userToAPI(item)
	}
	return result, nil
}
func (h *WorkflowHandler) UpdateUserRoles(ctx context.Context, request oapi.UpdateUserRolesRequestObject) (oapi.UpdateUserRolesResponseObject, error) {
	if !h.hasRole(ctx, user.ADMIN) {
		return oapi.UpdateUserRoles403ApplicationProblemPlusJSONResponse{ForbiddenApplicationProblemPlusJSONResponse: oapi.NewForbiddenResponse("se requiere administración")}, nil
	}
	roles := make([]user.RoleName, len(request.Body.Roles))
	for i, role := range request.Body.Roles {
		roles[i] = user.RoleName(role)
	}
	item, err := h.users.ReplaceRoles(ctx, user.UserId(request.Id), roles)
	if errors.Is(err, sql.ErrNoRows) {
		return oapi.UpdateUserRoles404ApplicationProblemPlusJSONResponse{NotFoundApplicationProblemPlusJSONResponse: oapi.NewNotFoundResponse(err.Error())}, nil
	}
	if err != nil {
		return nil, err
	}
	return oapi.UpdateUserRoles200JSONResponse(userToAPI(*item)), nil
}

func procedureFromAPI(input oapi.ProcedureDefinition) petrunia.Net {
	net := petrunia.Net{InitialPlaceID: petrunia.NodeID(input.InitialPlaceId), FinalPlaceID: petrunia.NodeID(input.FinalPlaceId)}
	for _, n := range input.Nodes {
		if string(n.Kind) == "place" {
			net.Places = append(net.Places, petrunia.Place{ID: petrunia.NodeID(n.Id), Label: n.Label, X: n.X, Y: n.Y})
		} else {
			role := petrunia.Role("")
			if n.Role != nil {
				role = petrunia.Role(*n.Role)
			}
			net.Transitions = append(net.Transitions, petrunia.Transition{ID: petrunia.NodeID(n.Id), Label: n.Label, Role: role, X: n.X, Y: n.Y})
		}
	}
	for _, a := range input.Arcs {
		net.Arcs = append(net.Arcs, petrunia.Arc{ID: a.Id, From: petrunia.NodeID(a.From), To: petrunia.NodeID(a.To)})
	}
	return net
}
func procedureToAPI(net petrunia.Net) oapi.ProcedureDefinition {
	result := oapi.ProcedureDefinition{InitialPlaceId: string(net.InitialPlaceID), FinalPlaceId: string(net.FinalPlaceID), Arcs: make([]oapi.ProcedureArc, len(net.Arcs))}
	for _, p := range net.Places {
		result.Nodes = append(result.Nodes, oapi.ProcedureNode{Id: string(p.ID), Kind: oapi.ProcedureNodeKind("place"), Label: p.Label, X: p.X, Y: p.Y})
	}
	for _, t := range net.Transitions {
		role := oapi.ProcedureRole(t.Role)
		result.Nodes = append(result.Nodes, oapi.ProcedureNode{Id: string(t.ID), Kind: oapi.ProcedureNodeKind("transition"), Label: t.Label, Role: &role, X: t.X, Y: t.Y})
	}
	for i, a := range net.Arcs {
		result.Arcs[i] = oapi.ProcedureArc{Id: a.ID, From: string(a.From), To: string(a.To)}
	}
	return result
}
func procedureVersionToAPI(v catalog.ProcedureVersion) oapi.ProcedureVersion {
	return oapi.ProcedureVersion{Id: v.ID, TramiteId: int64(v.TramiteID), VersionNumber: v.VersionNumber, Status: oapi.ProcedureVersionStatus(v.Status), Definition: procedureToAPI(v.Definition)}
}
func summaryToAPI(v cases.Summary) oapi.CaseSummary {
	return oapi.CaseSummary{Id: v.ID, TramiteId: v.TramiteID, TramiteName: v.TramiteName, Status: oapi.CaseSummaryStatus(v.Status), Revision: v.Revision, StartedAt: v.StartedAt, UpdatedAt: v.UpdatedAt}
}
func caseToAPI(v cases.Case) oapi.Case {
	marking := map[string]int{}
	for id, n := range v.Marking {
		marking[string(id)] = int(n)
	}
	result := oapi.Case{Id: v.ID, TramiteId: v.TramiteID, TramiteName: v.TramiteName, ProcedureVersionId: v.ProcedureVersionID, ProcedureVersion: v.ProcedureVersion, Status: oapi.CaseStatus(v.Status), Revision: v.Revision, Marking: marking, Definition: procedureToAPI(v.Definition), StartedAt: v.StartedAt, UpdatedAt: v.UpdatedAt, CompletedAt: v.CompletedAt}
	for _, id := range v.EnabledTransitions {
		result.EnabledTransitions = append(result.EnabledTransitions, string(id))
	}
	for _, p := range v.Participants {
		result.Participants = append(result.Participants, oapi.Participant{Role: oapi.ProcedureRole(p.Role), UserId: p.UserID, Name: p.Name, AssignedAt: p.AssignedAt})
	}
	for _, t := range v.AvailableTasks {
		result.AvailableTasks = append(result.AvailableTasks, taskToAPI(t))
	}
	for _, a := range v.History {
		result.History = append(result.History, oapi.CaseAction{Id: a.ID, TransitionId: string(a.TransitionID), TransitionLabel: a.TransitionLabel, ActorId: a.ActorID, ActorName: a.ActorName, OccurredAt: a.OccurredAt})
	}
	return result
}
func taskToAPI(v cases.Task) oapi.Task {
	return oapi.Task{Id: v.ID, CaseId: v.CaseID, TransitionId: string(v.TransitionID), TransitionLabel: v.TransitionLabel, Role: oapi.ProcedureRole(v.Role), AssigneeId: v.AssigneeID, Status: oapi.TaskStatus(v.Status), CreatedAt: v.CreatedAt}
}
func notificationToAPI(v cases.Notification) oapi.Notification {
	return oapi.Notification{Id: v.ID, CaseId: v.CaseID, TaskId: v.TaskID, Type: oapi.NotificationType(v.Type), Title: v.Title, CreatedAt: v.CreatedAt, ReadAt: v.ReadAt}
}
func userToAPI(v user.User) oapi.User {
	roles := make([]string, len(v.Roles))
	for i, r := range v.Roles {
		roles[i] = string(r)
	}
	return oapi.User{Id: int64(v.ID), Name: v.Name, Sub: v.Sub, Email: openapi_types.Email(v.Email), EmailVerified: v.EmailVerified, Roles: roles}
}
