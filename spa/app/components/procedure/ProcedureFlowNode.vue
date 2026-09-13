<script setup lang="ts">
import { Handle, Position, type NodeProps } from "@vue-flow/core";
import type { ProcedureFlowData } from "~/utils/procedure";

defineProps<NodeProps<ProcedureFlowData>>();
</script>

<template>
  <div
    class="relative flex items-center justify-center"
    :class="[
      data.kind === 'place' ? 'size-14' : 'h-16 w-6',
      data.actionable ? 'cursor-pointer' : '',
    ]"
    :aria-label="data.label"
  >
    <Handle type="target" :position="Position.Left" :connectable="connectable" />
    <div
      :class="[
        data.kind === 'place' ? 'size-14 rounded-full' : 'h-16 w-6 rounded',
        data.kind === 'place'
          ? data.active
            ? 'border-3 border-emerald-700 bg-emerald-100'
            : 'border-3 border-slate-600 bg-white'
          : data.actionable
            ? 'border-2 border-emerald-800 bg-emerald-400'
            : data.enabled
              ? 'border-2 border-amber-700 bg-amber-300'
              : 'border-2 border-slate-900 bg-slate-700',
      ]"
    />
    <Handle type="source" :position="Position.Right" :connectable="connectable" />
    <span class="absolute top-full mt-2 w-36 text-center text-xs font-medium text-slate-700">{{
      data.label
    }}</span>
  </div>
</template>
