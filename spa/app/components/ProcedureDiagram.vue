<script setup lang="ts">
import type { ProcedureGraph } from "~/types/tunkunia";

const props = withDefaults(
  defineProps<{ graph: ProcedureGraph; activeNodeIds?: string[]; title?: string }>(),
  { activeNodeIds: () => [], title: "Diagrama del procedimiento" },
);

const nodes = computed(() => new Map(props.graph.nodes.map((node) => [node.id, node])));
const width = computed(() => Math.max(760, ...props.graph.nodes.map((node) => node.x + 90)));
const height = computed(() => Math.max(230, ...props.graph.nodes.map((node) => node.y + 90)));
</script>

<template>
  <div class="diagram-shell" role="img" :aria-label="title">
    <svg :viewBox="`0 0 ${width} ${height}`" class="min-w-[680px] w-full" aria-hidden="true">
      <defs>
        <marker
          id="procedure-arrow"
          viewBox="0 0 10 10"
          refX="9"
          refY="5"
          markerWidth="7"
          markerHeight="7"
          orient="auto-start-reverse"
        >
          <path d="M 0 0 L 10 5 L 0 10 z" fill="currentColor" />
        </marker>
      </defs>
      <g v-for="arc in graph.arcs" :key="arc.id" class="text-slate-400">
        <line
          v-if="nodes.get(arc.from) && nodes.get(arc.to)"
          :x1="nodes.get(arc.from)!.x"
          :y1="nodes.get(arc.from)!.y"
          :x2="nodes.get(arc.to)!.x"
          :y2="nodes.get(arc.to)!.y"
          stroke="currentColor"
          stroke-width="2"
          marker-end="url(#procedure-arrow)"
        />
      </g>
      <g v-for="node in graph.nodes" :key="node.id">
        <circle
          v-if="node.kind === 'place'"
          :cx="node.x"
          :cy="node.y"
          r="27"
          :class="
            activeNodeIds.includes(node.id)
              ? 'fill-emerald-100 stroke-emerald-700'
              : 'fill-white stroke-slate-600'
          "
          stroke-width="3"
        />
        <rect
          v-else
          :x="node.x - 12"
          :y="node.y - 35"
          width="24"
          height="70"
          rx="3"
          :class="
            activeNodeIds.includes(node.id)
              ? 'fill-amber-300 stroke-amber-700'
              : 'fill-slate-700 stroke-slate-900'
          "
          stroke-width="2"
        />
        <text
          :x="node.x"
          :y="node.y + 58"
          text-anchor="middle"
          class="fill-slate-700 text-[13px] font-medium"
        >
          {{ node.label }}
        </text>
      </g>
    </svg>
  </div>
</template>
