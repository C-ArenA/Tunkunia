export type ProcedureNodeKind = "place" | "transition";

export interface ProcedureNode {
  id: string;
  kind: ProcedureNodeKind;
  label: string;
  x: number;
  y: number;
  role?: "citizen" | "servant";
}

export interface ProcedureArc {
  id: string;
  from: string;
  to: string;
}

export interface ProcedureGraph {
  nodes: ProcedureNode[];
  arcs: ProcedureArc[];
  initialPlaceId: string;
  finalPlaceId: string;
}

export interface InstitutionSettings {
  name: string;
  acronym: string;
  description: string;
  logoUrl: string;
  email: string;
  phone: string;
  address: string;
  website: string;
  primaryColor: string;
  accentColor: string;
}
