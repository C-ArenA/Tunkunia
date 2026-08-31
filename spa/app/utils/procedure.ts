import type { ProcedureDefinition } from "#shared/clientV1/types.gen";

export function newProcedure(): ProcedureDefinition {
  return {
    nodes: [
      { id: "start", kind: "place", label: "Inicio", x: 80, y: 120 },
      {
        id: "submit",
        kind: "transition",
        label: "Presentar solicitud",
        role: "citizen",
        x: 230,
        y: 120,
      },
      { id: "waiting", kind: "place", label: "En revisión", x: 380, y: 120 },
      {
        id: "approve",
        kind: "transition",
        label: "Aprobar solicitud",
        role: "servant",
        x: 530,
        y: 120,
      },
      { id: "end", kind: "place", label: "Concluido", x: 680, y: 120 },
    ],
    arcs: [
      { id: "a1", from: "start", to: "submit" },
      { id: "a2", from: "submit", to: "waiting" },
      { id: "a3", from: "waiting", to: "approve" },
      { id: "a4", from: "approve", to: "end" },
    ],
    initialPlaceId: "start",
    finalPlaceId: "end",
  };
}
