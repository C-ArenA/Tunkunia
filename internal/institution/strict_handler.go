package institution

import (
	"context"
	"database/sql"
	"errors"
	"net/mail"
	"net/url"
	"strings"

	"github.com/C-ArenA/Tunkunia/internal/api/v1/oapi"
	"github.com/C-ArenA/Tunkunia/internal/authn"
)

type repository interface {
	Get(context.Context) (oapi.Institution, error)
	Update(context.Context, oapi.Institution) (oapi.Institution, error)
}

type userAccess interface {
	IsAdmin(context.Context, int64) (bool, error)
}

type StrictHandlerV1 struct {
	repo  repository
	users userAccess
	demo  bool
}

func NewStrictHandlerV1(repo repository, users userAccess, demo bool) *StrictHandlerV1 {
	return &StrictHandlerV1{repo: repo, users: users, demo: demo}
}

func (h *StrictHandlerV1) GetInstitution(ctx context.Context, _ oapi.GetInstitutionRequestObject) (oapi.GetInstitutionResponseObject, error) {
	value, err := h.repo.Get(ctx)
	if errors.Is(err, sql.ErrNoRows) {
		return oapi.GetInstitution404ApplicationProblemPlusJSONResponse{NotFoundApplicationProblemPlusJSONResponse: oapi.NewNotFoundResponse("institución no encontrada")}, nil
	}
	if err != nil {
		return nil, err
	}
	value.Demo = h.demo
	return oapi.GetInstitution200JSONResponse(value), nil
}

func (h *StrictHandlerV1) UpdateInstitution(ctx context.Context, request oapi.UpdateInstitutionRequestObject) (oapi.UpdateInstitutionResponseObject, error) {
	p, ok := authn.FromAuthContext(ctx)
	if !ok || p.Type != authn.UserPrincipal {
		return oapi.UpdateInstitution401ApplicationProblemPlusJSONResponse{UnauthorizedApplicationProblemPlusJSONResponse: oapi.NewUnauthorizedResponse("se requiere autenticación")}, nil
	}
	admin, err := h.users.IsAdmin(ctx, int64(p.ID))
	if err != nil {
		return nil, err
	}
	if !admin {
		return oapi.UpdateInstitution403ApplicationProblemPlusJSONResponse{ForbiddenApplicationProblemPlusJSONResponse: oapi.NewForbiddenResponse("se requiere administración")}, nil
	}
	if request.Body == nil {
		return oapi.UpdateInstitution400ApplicationProblemPlusJSONResponse{BadRequestApplicationProblemPlusJSONResponse: oapi.NewBadRequestResponse("la configuración es obligatoria")}, nil
	}
	if err := validate(*request.Body); err != nil {
		return oapi.UpdateInstitution400ApplicationProblemPlusJSONResponse{BadRequestApplicationProblemPlusJSONResponse: oapi.NewBadRequestResponse(err.Error())}, nil
	}
	value, err := h.repo.Update(ctx, *request.Body)
	if err != nil {
		return nil, err
	}
	return oapi.UpdateInstitution200JSONResponse(value), nil
}

func validate(value oapi.Institution) error {
	if value.Name == "" || value.Acronym == "" {
		return errors.New("el nombre y la sigla son obligatorios")
	}
	for _, color := range []string{value.PrimaryColor, value.AccentColor} {
		if !isHexColor(color) {
			return errors.New("los colores deben usar formato hexadecimal")
		}
	}
	if value.Email != "" {
		if _, err := mail.ParseAddress(value.Email); err != nil {
			return errors.New("el correo no es válido")
		}
	}
	for _, candidate := range []string{value.LogoUrl, value.Website} {
		if candidate == "" {
			continue
		}
		parsed, err := url.Parse(candidate)
		if err != nil || ((!strings.EqualFold(parsed.Scheme, "http") && !strings.EqualFold(parsed.Scheme, "https")) || parsed.Host == "") {
			return errors.New("las URLs deben usar http o https")
		}
	}
	return nil
}

func isHexColor(value string) bool {
	if len(value) != 7 || value[0] != '#' {
		return false
	}
	for _, char := range value[1:] {
		if !strings.ContainsRune("0123456789abcdefABCDEF", char) {
			return false
		}
	}
	return true
}
