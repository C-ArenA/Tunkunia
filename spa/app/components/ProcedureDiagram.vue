<script setup lang="ts">
import "@vue-flow/core/dist/style.css";
import "@vue-flow/core/dist/theme-default.css";
import ProcedureCanvas from "./procedure/ProcedureCanvas.vue";
import type { Net } from "#shared/clientV1/types.gen";

withDefaults(
  defineProps<{
    graph: Net;
    activeNodeIds?: string[];
    enabledTransitionIds?: string[];
    actionableTransitionIds?: string[];
    title?: string;
  }>(),
  {
    activeNodeIds: () => [],
    enabledTransitionIds: () => [],
    actionableTransitionIds: () => [],
    title: "Diagrama del procedimiento",
  },
);
const emit = defineEmits<{ transition: [id: string] }>();
</script>

<template>
  <div role="group" :aria-label="title">
    <ProcedureCanvas
      :graph="graph"
      :active-node-ids="activeNodeIds"
      :enabled-transition-ids="enabledTransitionIds"
      :actionable-transition-ids="actionableTransitionIds"
      @transition="emit('transition', $event)"
    />
  </div>
</template>
