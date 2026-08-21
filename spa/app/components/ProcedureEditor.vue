<script setup lang="ts">
import type {
  ProcedureArc,
  ProcedureGraph,
  ProcedureNode,
  ProcedureNodeKind,
} from "~/types/tunkunia";
const props = defineProps<{ modelValue: ProcedureGraph }>();
const emit = defineEmits<{ "update:modelValue": [value: ProcedureGraph] }>();
const graph = computed({
  get: () => props.modelValue,
  set: (value) => emit("update:modelValue", value),
});
const from = ref("");
const to = ref("");
const error = ref("");
function updateNode(id: string, patch: Partial<ProcedureNode>) {
  graph.value = {
    ...graph.value,
    nodes: graph.value.nodes.map((node) => (node.id === id ? { ...node, ...patch } : node)),
  };
}
function addNode(kind: ProcedureNodeKind) {
  const id = `${kind === "place" ? "p" : "t"}-${Date.now()}`;
  graph.value = {
    ...graph.value,
    nodes: [
      ...graph.value.nodes,
      {
        id,
        kind,
        label: kind === "place" ? "Nuevo estado" : "Nueva actividad",
        x: 100 + graph.value.nodes.length * 90,
        y: 110,
      },
    ],
  };
}
function removeNode(id: string) {
  graph.value = {
    nodes: graph.value.nodes.filter((node) => node.id !== id),
    arcs: graph.value.arcs.filter((arc) => arc.from !== id && arc.to !== id),
  };
}
function addArc() {
  error.value = "";
  const a = graph.value.nodes.find((node) => node.id === from.value);
  const b = graph.value.nodes.find((node) => node.id === to.value);
  if (!a || !b) return;
  if (a.id === b.id || a.kind === b.kind) {
    error.value = "Una conexión debe unir un círculo con una caja.";
    return;
  }
  if (graph.value.arcs.some((arc) => arc.from === a.id && arc.to === b.id)) {
    error.value = "Esa conexión ya existe.";
    return;
  }
  const arc: ProcedureArc = { id: `a-${Date.now()}`, from: a.id, to: b.id };
  graph.value = { ...graph.value, arcs: [...graph.value.arcs, arc] };
  from.value = "";
  to.value = "";
}
</script>
<template>
  <div class="grid gap-6 2xl:grid-cols-[430px_1fr]">
    <div class="space-y-5">
      <div class="surface p-5">
        <div class="flex items-center justify-between">
          <div>
            <h3 class="font-semibold">Elementos</h3>
            <p class="mt-1 text-xs text-slate-500">Círculos son estados; cajas son actividades.</p>
          </div>
          <div class="flex gap-2">
            <UButton
              size="sm"
              icon="i-lucide-circle"
              label="Círculo"
              color="neutral"
              variant="soft"
              @click="addNode('place')"
            /><UButton
              size="sm"
              icon="i-lucide-square"
              label="Caja"
              color="neutral"
              variant="soft"
              @click="addNode('transition')"
            />
          </div>
        </div>
        <div class="mt-4 max-h-80 space-y-3 overflow-y-auto">
          <div
            v-for="node in graph.nodes"
            :key="node.id"
            class="rounded-xl border border-slate-200 p-3"
          >
            <div class="flex items-center gap-2">
              <UIcon
                :name="node.kind === 'place' ? 'i-lucide-circle' : 'i-lucide-square'"
                class="size-4"
              /><UInput
                :model-value="node.label"
                class="flex-1"
                @update:model-value="updateNode(node.id, { label: String($event) })"
              /><UButton
                icon="i-lucide-trash-2"
                color="error"
                variant="ghost"
                size="sm"
                aria-label="Eliminar elemento"
                @click="removeNode(node.id)"
              />
            </div>
            <div class="mt-2 grid grid-cols-2 gap-2">
              <UInput
                type="number"
                :model-value="node.x"
                @update:model-value="updateNode(node.id, { x: Number($event) })"
              /><UInput
                type="number"
                :model-value="node.y"
                @update:model-value="updateNode(node.id, { y: Number($event) })"
              />
            </div>
          </div>
        </div>
      </div>
      <div class="surface p-5">
        <h3 class="font-semibold">Conexiones dirigidas</h3>
        <div class="mt-4 grid grid-cols-[1fr_auto_1fr] items-center gap-2">
          <USelect
            v-model="from"
            :items="graph.nodes.map((n) => ({ label: n.label, value: n.id }))"
            placeholder="Origen"
          /><UIcon name="i-lucide-arrow-right" /><USelect
            v-model="to"
            :items="graph.nodes.map((n) => ({ label: n.label, value: n.id }))"
            placeholder="Destino"
          />
        </div>
        <p v-if="error" class="mt-2 text-xs text-red-600">{{ error }}</p>
        <UButton
          class="mt-3"
          size="sm"
          label="Añadir conexión"
          icon="i-lucide-plus"
          @click="addArc"
        />
        <div class="mt-4 space-y-2">
          <div
            v-for="arc in graph.arcs"
            :key="arc.id"
            class="flex items-center justify-between rounded-lg bg-slate-50 px-3 py-2 text-xs"
          >
            <span
              >{{ graph.nodes.find((n) => n.id === arc.from)?.label }} →
              {{ graph.nodes.find((n) => n.id === arc.to)?.label }}</span
            ><UButton
              icon="i-lucide-x"
              size="xs"
              color="error"
              variant="ghost"
              @click="graph = { ...graph, arcs: graph.arcs.filter((a) => a.id !== arc.id) }"
            />
          </div>
        </div>
      </div>
    </div>
    <div>
      <p class="mb-3 text-sm font-semibold">Vista previa</p>
      <ProcedureDiagram :graph="graph" />
    </div>
  </div>
</template>
