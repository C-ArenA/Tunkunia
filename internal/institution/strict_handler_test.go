package institution

import (
	"context"
	"testing"

	"github.com/C-ArenA/Tunkunia/internal/api/v1/oapi"
	"github.com/C-ArenA/Tunkunia/internal/authn"
	"github.com/stretchr/testify/require"
)

type memoryRepository struct {
	value oapi.Institution
}

func (r *memoryRepository) Get(context.Context) (oapi.Institution, error) { return r.value, nil }
func (r *memoryRepository) Update(_ context.Context, value oapi.Institution) (oapi.Institution, error) {
	r.value = value
	return value, nil
}

type accessRepository struct{ admin bool }

func (r accessRepository) IsAdmin(context.Context, int64) (bool, error) { return r.admin, nil }

func TestValidateInstitution(t *testing.T) {
	valid := oapi.Institution{Name: "Tunkunia", Acronym: "T", PrimaryColor: "#087443", AccentColor: "#d3a000"}
	require.NoError(t, validate(valid))
	valid.PrimaryColor = "green"
	require.Error(t, validate(valid))
	valid.PrimaryColor = "#087443"
	valid.Name = ""
	require.Error(t, validate(valid))
}

func TestUpdateInstitutionRequiresAdmin(t *testing.T) {
	handler := NewStrictHandlerV1(&memoryRepository{}, accessRepository{})
	body := oapi.Institution{Name: "Tunkunia", Acronym: "T", PrimaryColor: "#087443", AccentColor: "#d3a000"}
	response, err := handler.UpdateInstitution(context.Background(), oapi.UpdateInstitutionRequestObject{Body: &body})
	require.NoError(t, err)
	_, ok := response.(oapi.UpdateInstitution401ApplicationProblemPlusJSONResponse)
	require.True(t, ok)
}

func TestUpdateInstitutionPersistsForAdmin(t *testing.T) {
	repo := &memoryRepository{}
	handler := NewStrictHandlerV1(repo, accessRepository{admin: true})
	body := oapi.Institution{Name: "Gobierno", Acronym: "G", PrimaryColor: "#087443", AccentColor: "#d3a000"}
	ctx := authn.NewAuthContext(context.Background(), &authn.Principal{ID: 1, Type: authn.UserPrincipal})
	response, err := handler.UpdateInstitution(ctx, oapi.UpdateInstitutionRequestObject{Body: &body})
	require.NoError(t, err)
	_, ok := response.(oapi.UpdateInstitution200JSONResponse)
	require.True(t, ok)
	require.Equal(t, "Gobierno", repo.value.Name)
}

func TestValidateInstitutionRejectsMissingColors(t *testing.T) {
	err := validate(oapi.Institution{Name: "Tunkunia", Acronym: "T"})
	require.Error(t, err)
}
