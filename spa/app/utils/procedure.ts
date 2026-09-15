import { Position, type Edge, type Node } from "@vue-flow/core";
import type {
  Net,
  ProcedureNode as ApiProcedureNode,
  ProcedureRole,
} from "#shared/clientV1/types.gen";

export type ProcedureFlowData = {
  kind: ApiProcedureNode["kind"];
  label: string;
  role?: ProcedureRole;
  active: boolean;
  enabled: boolean;
  actionable: boolean;
};

export type FlowProcedureNode = Node<ProcedureFlowData> & {
  data: ProcedureFlowData;
};

const dimensions = (kind: ApiProcedureNode["kind"]) =>
  kind === "place" ? { width: 56, height: 56 } : { width: 24, height: 70 };

export function newProcedure(): Net {
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

export function procedureToFlow(
  net: Net,
  state: Pick<ProcedureFlowData, "active" | "enabled" | "actionable"> = {
    active: false,
    enabled: false,
    actionable: false,
  },
): { nodes: FlowProcedureNode[]; edges: Edge[] } {
  return {
    nodes: net.nodes.map((node) => {
      const size = dimensions(node.kind);
      return {
        id: node.id,
        type: `procedure-${node.kind}`,
        position: { x: node.x - size.width / 2, y: node.y - size.height / 2 },
        data: { ...state, kind: node.kind, label: node.label, role: node.role },
        sourcePosition: Position.Right,
        targetPosition: Position.Left,
        deletable: false,
        ariaLabel: node.label,
      };
    }),
    edges: net.arcs.map((arc) => ({
      id: arc.id,
      source: arc.from,
      target: arc.to,
      type: "smoothstep",
      animated: false,
      class: "procedure-edge",
    })),
  };
}

export function flowToProcedure(nodes: FlowProcedureNode[], edges: Edge[], previous: Net): Net {
  const nodeIds = new Set(nodes.map((node) => node.id));
  return {
    ...previous,
    initialPlaceId: nodeIds.has(previous.initialPlaceId) ? previous.initialPlaceId : "",
    finalPlaceId: nodeIds.has(previous.finalPlaceId) ? previous.finalPlaceId : "",
    nodes: nodes.map((node) => {
      const size = dimensions(node.data.kind);
      return {
        id: node.id,
        kind: node.data.kind,
        label: node.data.label,
        ...(node.data.kind === "transition" && node.data.role ? { role: node.data.role } : {}),
        x: Math.round(node.position.x + size.width / 2),
        y: Math.round(node.position.y + size.height / 2),
      };
    }),
    arcs: edges.map((edge) => ({ id: edge.id, from: edge.source, to: edge.target })),
  };
}

export function canConnect(
  connection: { source?: string | null; target?: string | null },
  nodes: FlowProcedureNode[],
  edges: Edge[],
): string | undefined {
  const source = nodes.find((node) => node.id === connection.source);
  const target = nodes.find((node) => node.id === connection.target);
  if (!source || !target) return "Selecciona un origen y un destino.";
  if (source.id === target.id || source.data.kind === target.data.kind) {
    return "Una conexión debe unir un círculo con una caja.";
  }
  if (edges.some((edge) => edge.source === source.id && edge.target === target.id)) {
    return "Esa conexión ya existe.";
  }
  return undefined;
}
