import type { DemoCase, DemoState, DemoTask, ProcedureGraph } from "~/types/tunkunia";

const STORAGE_KEY = "tunkunia.demo.v1";

const defaultGraph = (): ProcedureGraph => ({
  nodes: [
    { id: "p-inicio", kind: "place", label: "Solicitud preparada", x: 70, y: 100 },
    { id: "t-revision", kind: "transition", label: "Revisión de requisitos", x: 210, y: 100 },
    { id: "p-revision", kind: "place", label: "En evaluación", x: 360, y: 100 },
    { id: "t-resolucion", kind: "transition", label: "Emitir resolución", x: 510, y: 100 },
    { id: "p-fin", kind: "place", label: "Trámite concluido", x: 650, y: 100 },
  ],
  arcs: [
    { id: "a1", from: "p-inicio", to: "t-revision" },
    { id: "a2", from: "t-revision", to: "p-revision" },
    { id: "a3", from: "p-revision", to: "t-resolucion" },
    { id: "a4", from: "t-resolucion", to: "p-fin" },
  ],
});

const createInitialState = (): DemoState => ({
  version: 1,
  institution: {
    name: "Gobierno Autónomo Municipal de Tunkunia",
    acronym: "GAMT",
    description: "Servicios públicos digitales, claros y accesibles para toda la ciudadanía.",
    logoUrl: "",
    email: "contacto@tunkunia.gob.bo",
    phone: "+591 2 244 0000",
    address: "Plaza Principal, La Paz, Bolivia",
    website: "https://tunkunia.gob.bo",
    primaryColor: "#087443",
    accentColor: "#d3a000",
  },
  graphs: { "1": defaultGraph(), "2": defaultGraph() },
  cases: [
    {
      id: "TK-2026-0042",
      tramiteId: 1,
      tramiteName: "Inscripción de personería jurídica",
      participantId: 1,
      status: "active",
      startedAt: "2026-08-03T14:00:00.000Z",
      updatedAt: "2026-08-18T16:30:00.000Z",
      progress: 50,
      activeNodeIds: ["p-revision"],
      history: [
        { at: "2026-08-03T14:00:00.000Z", label: "Caso iniciado" },
        { at: "2026-08-18T16:30:00.000Z", label: "Requisitos recibidos" },
      ],
    },
    {
      id: "TK-2026-0019",
      tramiteId: 2,
      tramiteName: "Certificación de registro",
      participantId: 1,
      status: "completed",
      startedAt: "2026-06-10T13:00:00.000Z",
      updatedAt: "2026-06-21T17:00:00.000Z",
      progress: 100,
      activeNodeIds: ["p-fin"],
      history: [
        { at: "2026-06-10T13:00:00.000Z", label: "Caso iniciado" },
        { at: "2026-06-21T17:00:00.000Z", label: "Trámite concluido" },
      ],
    },
  ],
  tasks: [
    {
      id: "task-1",
      caseId: "TK-2026-0042",
      title: "Adjuntar acta de constitución",
      description: "Revise el documento y deje una nota antes de enviarlo a evaluación.",
      dueAt: "2026-08-25T23:59:00.000Z",
      status: "pending",
      note: "",
    },
    {
      id: "task-2",
      caseId: "TK-2026-0019",
      title: "Confirmar recepción del certificado",
      description: "La certificación está disponible para su descarga.",
      dueAt: "2026-06-22T23:59:00.000Z",
      status: "completed",
      note: "Recibido conforme.",
    },
  ],
  users: [
    { id: 1, name: "María Quispe", email: "maria.quispe@example.com", roles: ["citizen"] },
    { id: 2, name: "Juan Mamani", email: "juan.mamani@gob.bo", roles: ["servant", "admin"] },
    { id: 3, name: "Ana Flores", email: "ana.flores@example.com", roles: ["citizen"] },
  ],
});

export function useTunkuniaDemo() {
  const state = useState<DemoState>("tunkunia-demo", createInitialState);
  const hydrated = useState("tunkunia-demo-hydrated", () => false);

  const persist = () => {
    if (import.meta.client) localStorage.setItem(STORAGE_KEY, JSON.stringify(state.value));
  };

  if (import.meta.client && !hydrated.value) {
    const stored = localStorage.getItem(STORAGE_KEY);
    if (stored) {
      try {
        const parsed = JSON.parse(stored) as DemoState;
        if (parsed.version === 1) state.value = parsed;
      } catch {
        localStorage.removeItem(STORAGE_KEY);
      }
    }
    hydrated.value = true;
  }

  const reset = () => {
    state.value = createInitialState();
    persist();
  };

  const saveInstitution = (institution: DemoState["institution"]) => {
    state.value.institution = { ...institution };
    persist();
  };

  const getGraph = (tramiteId: number) => state.value.graphs[String(tramiteId)] ?? defaultGraph();
  const saveGraph = (tramiteId: number, graph: ProcedureGraph) => {
    state.value.graphs[String(tramiteId)] = structuredClone(graph);
    persist();
  };

  const startCase = (tramiteId: number, tramiteName: string, participantId: number) => {
    const now = new Date().toISOString();
    const id = `TK-${new Date().getFullYear()}-${String(Date.now()).slice(-4)}`;
    const graph = getGraph(tramiteId);
    const firstPlace = graph.nodes.find((node) => node.kind === "place");
    const newCase: DemoCase = {
      id,
      tramiteId,
      tramiteName,
      participantId,
      status: "active",
      startedAt: now,
      updatedAt: now,
      progress: 10,
      activeNodeIds: firstPlace ? [firstPlace.id] : [],
      history: [{ at: now, label: "Caso iniciado" }],
    };
    const task: DemoTask = {
      id: `task-${Date.now()}`,
      caseId: id,
      title: "Presentar requisitos iniciales",
      description: "Revise la información del trámite y confirme que cuenta con los requisitos.",
      dueAt: new Date(Date.now() + 7 * 86400000).toISOString(),
      status: "pending",
      note: "",
    };
    state.value.cases.unshift(newCase);
    state.value.tasks.unshift(task);
    persist();
    return newCase;
  };

  const completeTask = (id: string, note: string, attachmentName?: string) => {
    const task = state.value.tasks.find((item) => item.id === id);
    if (!task) return;
    task.status = "completed";
    task.note = note;
    task.attachmentName = attachmentName;
    const relatedCase = state.value.cases.find((item) => item.id === task.caseId);
    if (relatedCase) {
      relatedCase.progress = Math.min(relatedCase.progress + 25, 90);
      relatedCase.updatedAt = new Date().toISOString();
      relatedCase.history.push({
        at: relatedCase.updatedAt,
        label: `Tarea completada: ${task.title}`,
      });
    }
    persist();
  };

  const toggleAdmin = (userId: number) => {
    const user = state.value.users.find((item) => item.id === userId);
    if (!user) return;
    user.roles = user.roles.includes("admin")
      ? user.roles.filter((role) => role !== "admin")
      : [...user.roles, "admin"];
    persist();
  };

  return {
    state,
    reset,
    persist,
    saveInstitution,
    getGraph,
    saveGraph,
    startCase,
    completeTask,
    toggleAdmin,
  };
}
