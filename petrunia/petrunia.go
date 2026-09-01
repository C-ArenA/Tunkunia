// Package petrunia implements the pure Petri-net semantics used by Tunkunia.
// It deliberately knows nothing about users, persistence, HTTP, or case data.
package petrunia

import (
	"errors"
	"fmt"
	"sort"
	"strings"
)

type NodeID string

type Place struct {
	ID    NodeID `json:"id"`
	Label string `json:"label"`
	X     int    `json:"x"`
	Y     int    `json:"y"`
}

type Role string

const (
	RoleCitizen Role = "citizen"
	RoleServant Role = "servant"
)

func (r Role) Valid() bool { return r == RoleCitizen || r == RoleServant }

type Transition struct {
	ID    NodeID `json:"id"`
	Label string `json:"label"`
	Role  Role   `json:"role"`
	X     int    `json:"x"`
	Y     int    `json:"y"`
}

type Arc struct {
	ID   string `json:"id"`
	From NodeID `json:"from"`
	To   NodeID `json:"to"`
}

type Net struct {
	Places         []Place      `json:"places"`
	Transitions    []Transition `json:"transitions"`
	Arcs           []Arc        `json:"arcs"`
	InitialPlaceID NodeID       `json:"initialPlaceId"`
	FinalPlaceID   NodeID       `json:"finalPlaceId"`
}

type Marking map[NodeID]uint

var (
	ErrUnknownTransition  = errors.New("unknown transition")
	ErrTransitionDisabled = errors.New("transition is not enabled")
)

func InitialMarking(net Net) Marking { return Marking{net.InitialPlaceID: 1} }

func Enabled(net Net, marking Marking, transitionID NodeID) (bool, error) {
	found := false
	inputs := 0
	for _, t := range net.Transitions {
		if t.ID == transitionID {
			found = true
			break
		}
	}
	if !found {
		return false, ErrUnknownTransition
	}
	for _, arc := range net.Arcs {
		if arc.To == transitionID {
			inputs++
			if marking[arc.From] == 0 {
				return false, nil
			}
		}
	}
	return inputs > 0, nil
}

func EnabledTransitions(net Net, marking Marking) []Transition {
	result := make([]Transition, 0)
	for _, transition := range net.Transitions {
		enabled, _ := Enabled(net, marking, transition.ID)
		if enabled {
			result = append(result, transition)
		}
	}
	return result
}

func Fire(net Net, marking Marking, transitionID NodeID) (Marking, error) {
	enabled, err := Enabled(net, marking, transitionID)
	if err != nil {
		return nil, err
	}
	if !enabled {
		return nil, ErrTransitionDisabled
	}
	next := CloneMarking(marking)
	for _, arc := range net.Arcs {
		switch {
		case arc.To == transitionID:
			next[arc.From]--
			if next[arc.From] == 0 {
				delete(next, arc.From)
			}
		case arc.From == transitionID:
			next[arc.To]++
		}
	}
	return next, nil
}

func CloneMarking(marking Marking) Marking {
	clone := make(Marking, len(marking))
	for place, tokens := range marking {
		if tokens > 0 {
			clone[place] = tokens
		}
	}
	return clone
}

func IsFinal(net Net, marking Marking) bool {
	return len(marking) == 1 && marking[net.FinalPlaceID] == 1
}

type Violation struct {
	Code    string `json:"code"`
	Message string `json:"message"`
}

type ValidationOptions struct {
	MaxReachableMarkings int
}

func ValidateWorkflow(net Net, options ValidationOptions) []Violation {
	if options.MaxReachableMarkings <= 0 {
		options.MaxReachableMarkings = 10_000
	}
	violations, usable := validateStructure(net)
	if !usable {
		return violations
	}
	dynamic := validateDynamics(net, options.MaxReachableMarkings)
	return append(violations, dynamic...)
}

func validateStructure(net Net) ([]Violation, bool) {
	var violations []Violation
	places := map[NodeID]bool{}
	transitions := map[NodeID]bool{}
	for _, p := range net.Places {
		if p.ID == "" || places[p.ID] || transitions[p.ID] {
			violations = append(violations, violation("duplicate_node", "Los nodos deben tener identificadores únicos y no vacíos."))
		}
		places[p.ID] = true
	}
	for _, t := range net.Transitions {
		if t.ID == "" || places[t.ID] || transitions[t.ID] {
			violations = append(violations, violation("duplicate_node", "Los nodos deben tener identificadores únicos y no vacíos."))
		}
		if !t.Role.Valid() {
			violations = append(violations, violation("invalid_role", fmt.Sprintf("La transición %q debe pertenecer a citizen o servant.", t.ID)))
		}
		transitions[t.ID] = true
	}
	if len(places) == 0 || len(transitions) == 0 {
		violations = append(violations, violation("empty_net", "La red necesita al menos un lugar y una transición."))
	}
	if !places[net.InitialPlaceID] || !places[net.FinalPlaceID] || net.InitialPlaceID == net.FinalPlaceID {
		violations = append(violations, violation("invalid_boundary", "La red necesita lugares inicial y final diferentes y existentes."))
	}

	incoming := map[NodeID]int{}
	outgoing := map[NodeID]int{}
	edges := map[string]bool{}
	adj := map[NodeID][]NodeID{}
	rev := map[NodeID][]NodeID{}
	for _, arc := range net.Arcs {
		fromPlace, toPlace := places[arc.From], places[arc.To]
		fromTransition, toTransition := transitions[arc.From], transitions[arc.To]
		if (!fromPlace && !fromTransition) || (!toPlace && !toTransition) {
			violations = append(violations, violation("unknown_arc_node", fmt.Sprintf("El arco %q referencia un nodo inexistente.", arc.ID)))
			continue
		}
		if fromPlace == toPlace {
			violations = append(violations, violation("not_bipartite", fmt.Sprintf("El arco %q debe conectar un lugar con una transición.", arc.ID)))
			continue
		}
		key := string(arc.From) + "\x00" + string(arc.To)
		if edges[key] {
			violations = append(violations, violation("duplicate_arc", fmt.Sprintf("La conexión %s → %s está duplicada.", arc.From, arc.To)))
			continue
		}
		edges[key] = true
		incoming[arc.To]++
		outgoing[arc.From]++
		adj[arc.From] = append(adj[arc.From], arc.To)
		rev[arc.To] = append(rev[arc.To], arc.From)
	}
	if incoming[net.InitialPlaceID] != 0 || outgoing[net.FinalPlaceID] != 0 {
		violations = append(violations, violation("invalid_boundary", "El lugar inicial no puede tener entradas y el final no puede tener salidas."))
	}
	for p := range places {
		if p != net.InitialPlaceID && incoming[p] == 0 {
			violations = append(violations, violation("multiple_sources", fmt.Sprintf("El lugar %q es una fuente adicional.", p)))
		}
		if p != net.FinalPlaceID && outgoing[p] == 0 {
			violations = append(violations, violation("multiple_sinks", fmt.Sprintf("El lugar %q es un sumidero adicional.", p)))
		}
	}
	for t := range transitions {
		if incoming[t] == 0 || outgoing[t] == 0 {
			violations = append(violations, violation("dangling_transition", fmt.Sprintf("La transición %q necesita entradas y salidas.", t)))
		}
	}
	if places[net.InitialPlaceID] && places[net.FinalPlaceID] {
		fromStart := reachable(net.InitialPlaceID, adj)
		toEnd := reachable(net.FinalPlaceID, rev)
		for node := range places {
			if !fromStart[node] || !toEnd[node] {
				violations = append(violations, violation("node_outside_workflow", fmt.Sprintf("El nodo %q no pertenece a un camino entre inicio y fin.", node)))
			}
		}
		for node := range transitions {
			if !fromStart[node] || !toEnd[node] {
				violations = append(violations, violation("node_outside_workflow", fmt.Sprintf("El nodo %q no pertenece a un camino entre inicio y fin.", node)))
			}
		}
	}
	return deduplicate(violations), len(violations) == 0
}

func validateDynamics(net Net, limit int) []Violation {
	type state struct {
		marking Marking
		key     string
	}
	initial := InitialMarking(net)
	initialKey := markingKey(initial)
	queue := []state{{initial, initialKey}}
	markings := map[string]Marking{initialKey: initial}
	edges := map[string][]string{}
	fired := map[NodeID]bool{}
	unsafe := false
	tooComplex := false

	for len(queue) > 0 && !tooComplex {
		current := queue[0]
		queue = queue[1:]
		for _, transition := range EnabledTransitions(net, current.marking) {
			next, _ := Fire(net, current.marking, transition.ID)
			fired[transition.ID] = true
			for _, count := range next {
				if count > 1 {
					unsafe = true
				}
			}
			key := markingKey(next)
			edges[current.key] = append(edges[current.key], key)
			if _, exists := markings[key]; !exists {
				if len(markings) >= limit {
					tooComplex = true
					break
				}
				markings[key] = next
				queue = append(queue, state{next, key})
			}
		}
	}
	if tooComplex {
		return []Violation{violation("too_complex", fmt.Sprintf("La verificación superó el límite de %d marcados alcanzables.", limit))}
	}
	var violations []Violation
	if unsafe {
		violations = append(violations, violation("not_safe", "La red no es 1-segura: algún lugar puede acumular más de un token."))
	}
	finalKey := markingKey(Marking{net.FinalPlaceID: 1})
	if _, ok := markings[finalKey]; !ok {
		violations = append(violations, violation("final_unreachable", "El marcado final no es alcanzable."))
	} else {
		reverse := map[string][]string{}
		for from, tos := range edges {
			for _, to := range tos {
				reverse[to] = append(reverse[to], from)
			}
		}
		canFinish := reachable(finalKey, reverse)
		for key, marking := range markings {
			if marking[net.FinalPlaceID] > 0 && key != finalKey {
				violations = append(violations, violation("improper_completion", "Existe un marcado alcanzable con token final y tokens residuales."))
			}
			if !canFinish[key] {
				violations = append(violations, violation("deadlock", "Existe un marcado alcanzable desde el cual no puede completarse el caso."))
				break
			}
		}
	}
	for _, transition := range net.Transitions {
		if !fired[transition.ID] {
			violations = append(violations, violation("dead_transition", fmt.Sprintf("La transición %q nunca puede ejecutarse.", transition.ID)))
		}
	}
	return deduplicate(violations)
}

func reachable[T comparable](start T, adjacency map[T][]T) map[T]bool {
	seen := map[T]bool{start: true}
	queue := []T{start}
	for len(queue) > 0 {
		current := queue[0]
		queue = queue[1:]
		for _, next := range adjacency[current] {
			if !seen[next] {
				seen[next] = true
				queue = append(queue, next)
			}
		}
	}
	return seen
}

func markingKey(marking Marking) string {
	ids := make([]string, 0, len(marking))
	for id, tokens := range marking {
		if tokens > 0 {
			ids = append(ids, fmt.Sprintf("%s=%d", id, tokens))
		}
	}
	sort.Strings(ids)
	return strings.Join(ids, ",")
}

func violation(code, message string) Violation { return Violation{Code: code, Message: message} }

func deduplicate(input []Violation) []Violation {
	seen := map[string]bool{}
	result := make([]Violation, 0, len(input))
	for _, item := range input {
		key := item.Code + "\x00" + item.Message
		if !seen[key] {
			seen[key] = true
			result = append(result, item)
		}
	}
	return result
}
