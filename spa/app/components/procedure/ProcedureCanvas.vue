<script setup lang="ts">
import {
  MarkerType,
  Position,
  VueFlow,
  type Connection,
  type Edge,
  type NodeDragEvent,
  type NodeMouseEvent,
} from "@vue-flow/core";
import { Background } from "@vue-flow/background";
import { Controls } from "@vue-flow/controls";
import ProcedureFlowNode from "./ProcedureFlowNode.vue";
import {
  canConnect,
  flowToProcedure,
  procedureToFlow,
  type FlowProcedureNode,
} from "~/utils/procedure";
import type { Net } from "#shared/clientV1/types.gen";

const props = withDefaults(
  defineProps<{
    graph: Net;
    editable?: boolean;
    activeNodeIds?: string[];
    enabledTransitionIds?: string[];
    actionableTransitionIds?: string[];
  }>(),
  {
    editable: false,
    activeNodeIds: () => [],
    enabledTransitionIds: () => [],
    actionableTransitionIds: () => [],
  },
);
const emit = defineEmits<{
  "update:graph": [value: Net];
  transition: [id: string];
  "select-node": [id: string];
}>();

const flow = computed(() =>
  procedureToFlow(props.graph, {
    active: false,
    enabled: false,
    actionable: false,
  }),
);
const nodes = ref<FlowProcedureNode[]>([]);
const edges = ref<Edge[]>([]);
const connectionError = ref("");
const selectedNodeId = ref("");

watch(
  [
    flow,
    () => props.activeNodeIds,
    () => props.enabledTransitionIds,
    () => props.actionableTransitionIds,
  ],
  ([value]) => {
    nodes.value = value.nodes.map((node) => ({
      ...node,
      data: {
        ...node.data,
        active: props.activeNodeIds.includes(node.id),
        enabled: props.enabledTransitionIds.includes(node.id),
        actionable: props.actionableTransitionIds.includes(node.id),
      },
    }));
    edges.value = value.edges.map((edge) => ({
      ...edge,
      markerEnd: { type: MarkerType.ArrowClosed },
    }));
  },
  { immediate: true },
);

function emitGraph() {
  emit("update:graph", flowToProcedure(nodes.value, edges.value, props.graph));
}

function onNodeDragStop(event: NodeDragEvent) {
  if (!props.editable) return;
  const changed = event.node as FlowProcedureNode;
  const node = nodes.value.find((item) => item.id === changed.id);
  if (node) node.position = { ...changed.position };
  emitGraph();
}

function onConnect(connection: Connection) {
  connectionError.value = canConnect(connection, nodes.value, edges.value) ?? "";
  if (connectionError.value || !connection.source || !connection.target) return;
  edges.value.push({
    id: `a-${Date.now()}`,
    source: connection.source,
    target: connection.target,
    type: "smoothstep",
    markerEnd: { type: MarkerType.ArrowClosed },
    class: "procedure-edge",
  });
  emitGraph();
}

function onEdgesChange() {
  if (!props.editable) return;
  nextTick(emitGraph);
}

function selectNode({ node }: NodeMouseEvent) {
  selectedNodeId.value = node.id;
  emit("select-node", node.id);
  if (!props.editable && node.data.actionable) emit("transition", node.id);
}

defineExpose({
  removeSelected() {
    if (!selectedNodeId.value) return;
    nodes.value = nodes.value.filter((node) => node.id !== selectedNodeId.value);
    edges.value = edges.value.filter(
      (edge) => edge.source !== selectedNodeId.value && edge.target !== selectedNodeId.value,
    );
    selectedNodeId.value = "";
    emitGraph();
  },
  addNode(kind: "place" | "transition") {
    const id = `${kind === "place" ? "p" : "t"}-${Date.now()}`;
    nodes.value.push({
      id,
      type: `procedure-${kind}`,
      position: { x: 120 + nodes.value.length * 30, y: 100 + nodes.value.length * 20 },
      data: {
        kind,
        label: kind === "place" ? "Nuevo estado" : "Nueva actividad",
        role: kind === "transition" ? "citizen" : undefined,
        active: false,
        enabled: false,
        actionable: false,
      },
      sourcePosition: Position.Right,
      targetPosition: Position.Left,
      deletable: false,
    });
    emitGraph();
  },
});
</script>

<template>
  <div class="relative h-120 overflow-hidden p-0 border border-slate-200 rounded-xl bg-white">
    <VueFlow
      v-model:nodes="nodes"
      v-model:edges="edges"
      :node-types="{
        'procedure-place': ProcedureFlowNode,
        'procedure-transition': ProcedureFlowNode,
      }"
      :nodes-draggable="editable"
      :nodes-connectable="editable"
      :elements-selectable="true"
      delete-key-code="Delete"
      fit-view-on-init
      @connect="onConnect"
      @edges-change="onEdgesChange"
      @node-drag-stop="onNodeDragStop"
      @node-click="selectNode"
    >
      <Background :gap="18" />
      <Controls />
    </VueFlow>
    <p
      v-if="connectionError"
      class="absolute bottom-3 left-3 rounded bg-white px-3 py-2 text-xs text-red-600 shadow"
    >
      {{ connectionError }}
    </p>
  </div>
</template>
