package domain

import (
	"errors"
	"testing"

	"github.com/stretchr/testify/assert"
)

func TestEmailCreation(t *testing.T) {
	cases := []struct {
		inputMail     string
		expectedError error
	}{
		{"h@g", ErrInvalidEmail},
		{"hola@hola.com", nil},
		{"@hola.com", ErrInvalidEmail},
		{"", ErrInvalidEmail},
		{"c.c.c@g.g.g", nil},
		{"c..6@gmail.com", ErrInvalidEmail},
		{".carlos@gmail.com", ErrInvalidEmail},
	}
	for _, c := range cases {
		gotMail, gotError := NewEmail(c.inputMail)
		if c.expectedError == nil {
			assert.Nil(t, gotError, "correo '%s' no debería generar errores, pero genera: %v", c.inputMail, gotError)
		} else {
			assert.ErrorIs(t, gotError, c.expectedError, "Correo '%s' debería ocasionar error '%v', pero se obtuvo error %v", c.inputMail, c.expectedError, gotError)
		}

		expectedMail := Email(c.inputMail)
		if errors.Is(c.expectedError, ErrInvalidEmail) {
			expectedMail = Email("")
		}
		assert.Equal(t, expectedMail, gotMail, "Correo '%v' debe generar '%v', pero se obtuvo '%v'", c.inputMail, expectedMail, gotMail)
	}
}
