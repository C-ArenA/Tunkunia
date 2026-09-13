package catalog

import (
	"github.com/C-ArenA/Tunkunia/internal/api/v1/oapi"
	"github.com/C-ArenA/Tunkunia/petrunia"
)

func ProcedureFromRequest(input oapi.ProcedureDefinition) petrunia.Net {
	net := petrunia.Net{InitialPlaceID: petrunia.NodeID(input.InitialPlaceId), FinalPlaceID: petrunia.NodeID(input.FinalPlaceId)}
	for _, n := range input.Nodes {
		if string(n.Kind) == "place" {
			net.Places = append(net.Places, petrunia.Place{ID: petrunia.NodeID(n.Id), Label: n.Label, X: n.X, Y: n.Y})
			continue
		}
		role := petrunia.Role("")
		if n.Role != nil {
			role = petrunia.Role(*n.Role)
		}
		net.Transitions = append(net.Transitions, petrunia.Transition{ID: petrunia.NodeID(n.Id), Label: n.Label, Role: role, X: n.X, Y: n.Y})
	}
	for _, a := range input.Arcs {
		net.Arcs = append(net.Arcs, petrunia.Arc{ID: a.Id, From: petrunia.NodeID(a.From), To: petrunia.NodeID(a.To)})
	}
	return net
}

func ProcedureToResponse(net petrunia.Net) oapi.ProcedureDefinition {
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

func ProcedureVersionToResponse(v ProcedureVersion) oapi.ProcedureVersion {
	return oapi.ProcedureVersion{Id: v.ID, TramiteId: v.TramiteID, VersionNumber: v.VersionNumber, Status: oapi.ProcedureVersionStatus(v.Status), Definition: ProcedureToResponse(v.Definition)}
}
