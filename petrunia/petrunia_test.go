package petrunia

import (
	"testing"

	"github.com/stretchr/testify/assert"
	"github.com/stretchr/testify/require"
)

func TestLinearWorkflow(t *testing.T) {
	net := linearNet()
	require.Empty(t, ValidateWorkflow(net, ValidationOptions{}))
	marking := InitialMarking(net)
	assert.Equal(t, []Transition{net.Transitions[0]}, EnabledTransitions(net, marking))
	next, err := Fire(net, marking, "submit")
	require.NoError(t, err)
	assert.True(t, IsFinal(net, next))
	assert.False(t, IsFinal(net, marking), "Fire must not mutate the input marking")
}

func TestDisabledAndUnknownTransition(t *testing.T) {
	net := linearNet()
	_, err := Fire(net, Marking{"end": 1}, "submit")
	assert.ErrorIs(t, err, ErrTransitionDisabled)
	_, err = Fire(net, InitialMarking(net), "missing")
	assert.ErrorIs(t, err, ErrUnknownTransition)
}

func TestParallelSplitAndJoin(t *testing.T) {
	net := Net{
		Places: []Place{{ID: "i"}, {ID: "a"}, {ID: "b"}, {ID: "o"}},
		Transitions: []Transition{
			{ID: "split", Role: RoleCitizen},
			{ID: "join", Role: RoleServant},
		},
		Arcs: []Arc{
			{From: "i", To: "split"}, {From: "split", To: "a"}, {From: "split", To: "b"},
			{From: "a", To: "join"}, {From: "b", To: "join"}, {From: "join", To: "o"},
		},
		InitialPlaceID: "i", FinalPlaceID: "o",
	}
	require.Empty(t, ValidateWorkflow(net, ValidationOptions{}))
	marking, err := Fire(net, InitialMarking(net), "split")
	require.NoError(t, err)
	assert.Equal(t, Marking{"a": 1, "b": 1}, marking)
	marking, err = Fire(net, marking, "join")
	require.NoError(t, err)
	assert.True(t, IsFinal(net, marking))
}

func TestChoiceAndLoopRemainSound(t *testing.T) {
	t.Run("exclusive choice", func(t *testing.T) {
		net := Net{
			Places:      []Place{{ID: "i"}, {ID: "o"}},
			Transitions: []Transition{{ID: "accept", Role: RoleServant}, {ID: "reject", Role: RoleServant}},
			Arcs: []Arc{
				{From: "i", To: "accept"}, {From: "accept", To: "o"},
				{From: "i", To: "reject"}, {From: "reject", To: "o"},
			},
			InitialPlaceID: "i", FinalPlaceID: "o",
		}
		require.Empty(t, ValidateWorkflow(net, ValidationOptions{}))
		assert.Len(t, EnabledTransitions(net, InitialMarking(net)), 2)
	})

	t.Run("repeatable task", func(t *testing.T) {
		net := Net{
			Places:      []Place{{ID: "i"}, {ID: "review"}, {ID: "o"}},
			Transitions: []Transition{{ID: "enter", Role: RoleCitizen}, {ID: "repeat", Role: RoleServant}, {ID: "finish", Role: RoleServant}},
			Arcs: []Arc{
				{From: "i", To: "enter"}, {From: "enter", To: "review"},
				{From: "review", To: "repeat"}, {From: "repeat", To: "review"},
				{From: "review", To: "finish"}, {From: "finish", To: "o"},
			},
			InitialPlaceID: "i", FinalPlaceID: "o",
		}
		require.Empty(t, ValidateWorkflow(net, ValidationOptions{}))
	})
}

func TestValidationRejectsInvalidAndUnsoundNets(t *testing.T) {
	t.Run("same kind arc", func(t *testing.T) {
		net := linearNet()
		net.Arcs = append(net.Arcs, Arc{From: "start", To: "end"})
		assertViolation(t, ValidateWorkflow(net, ValidationOptions{}), "not_bipartite")
	})
	t.Run("deadlock", func(t *testing.T) {
		net := Net{
			Places:         []Place{{ID: "i"}, {ID: "a"}, {ID: "b"}, {ID: "o"}},
			Transitions:    []Transition{{ID: "split", Role: RoleCitizen}, {ID: "left", Role: RoleCitizen}, {ID: "right", Role: RoleCitizen}},
			Arcs:           []Arc{{From: "i", To: "split"}, {From: "split", To: "a"}, {From: "split", To: "b"}, {From: "a", To: "left"}, {From: "left", To: "o"}, {From: "b", To: "right"}, {From: "right", To: "o"}},
			InitialPlaceID: "i", FinalPlaceID: "o",
		}
		violations := ValidateWorkflow(net, ValidationOptions{})
		assertViolation(t, violations, "not_safe")
		assertViolation(t, violations, "final_unreachable")
	})
	t.Run("invalid role", func(t *testing.T) {
		net := linearNet()
		net.Transitions[0].Role = "admin"
		assertViolation(t, ValidateWorkflow(net, ValidationOptions{}), "invalid_role")
	})
}

func assertViolation(t *testing.T, violations []Violation, code string) {
	t.Helper()
	for _, item := range violations {
		if item.Code == code {
			return
		}
	}
	require.Fail(t, "missing violation", "wanted %q in %#v", code, violations)
}

func linearNet() Net {
	return Net{
		Places:         []Place{{ID: "start"}, {ID: "end"}},
		Transitions:    []Transition{{ID: "submit", Label: "Enviar", Role: RoleCitizen}},
		Arcs:           []Arc{{ID: "a1", From: "start", To: "submit"}, {ID: "a2", From: "submit", To: "end"}},
		InitialPlaceID: "start", FinalPlaceID: "end",
	}
}
