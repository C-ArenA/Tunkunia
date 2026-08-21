export type ProcedureNodeKind = "place" | "transition";

export interface ProcedureNode {
  id: string;
  kind: ProcedureNodeKind;
  label: string;
  x: number;
  y: number;
}

export interface ProcedureArc {
  id: string;
  from: string;
  to: string;
}

export interface ProcedureGraph {
  nodes: ProcedureNode[];
  arcs: ProcedureArc[];
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

export interface DemoCase {
  id: string;
  tramiteId: number;
  tramiteName: string;
  participantId: number;
  status: "active" | "completed";
  startedAt: string;
  updatedAt: string;
  progress: number;
  activeNodeIds: string[];
  history: { at: string; label: string }[];
}

export interface DemoTask {
  id: string;
  caseId: string;
  title: string;
  description: string;
  dueAt: string;
  status: "pending" | "completed";
  note: string;
  attachmentName?: string;
}

export interface DemoUser {
  id: number;
  name: string;
  email: string;
  roles: string[];
}

export interface DemoState {
  version: 1;
  institution: InstitutionSettings;
  graphs: Record<string, ProcedureGraph>;
  cases: DemoCase[];
  tasks: DemoTask[];
  users: DemoUser[];
}
