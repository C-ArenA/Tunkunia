<script setup lang="ts">
import "@vue-flow/core/dist/style.css";
import "@vue-flow/core/dist/theme-default.css";
import ProcedureCanvas from "./procedure/ProcedureCanvas.vue";
import type { ProcedureDefinition, ProcedureNode } from "#shared/clientV1/types.gen";

const props = defineProps<{ modelValue: ProcedureDefinition }>();
const emit = defineEmits<{ "update:modelValue": [value: ProcedureDefinition] }>();
const canvas = ref<InstanceType<typeof ProcedureCanvas>>();
const selectedId = ref("");

const selected = computed(() =>
  props.modelValue.nodes.find((node) => node.id === selectedId.value),
);
const places = computed(() => props.modelValue.nodes.filter((node) => node.kind === "place"));
const update = (patch: Partial<ProcedureNode>) => {
  if (!selected.value) return;
  emit("update:modelValue", {
    ...props.modelValue,
    nodes: props.modelValue.nodes.map((node) =>
      node.id === selected.value?.id ? { ...node, ...patch } : node,
    ),
  });
};

function addNode(kind: "place" | "transition") {
  canvas.value?.addNode(kind);
}
function removeSelected() {
  canvas.value?.removeSelected();
  selectedId.value = "";
}
</script>

<template>
  <div class="grid gap-6 xl:grid-cols-[minmax(0,1fr)_22rem]">
    <div class="min-w-0">
      <div class="mb-4 flex flex-wrap items-center justify-between gap-3">
        <div>
          <h3 class="font-semibold">Editor visual</h3>
          <p class="mt-1 text-xs text-slate-500">
            Arrastra elementos, conecta círculos con actividades y pulsa Suprimir para quitar una
            conexión.
          </p>
        </div>
        <div class="flex gap-2">
          <UButton
            size="sm"
            icon="i-lucide-circle"
            label="Estado"
            color="neutral"
            variant="soft"
            @click="addNode('place')"
          />
          <UButton
            size="sm"
            icon="i-lucide-square"
            label="Actividad"
            color="neutral"
            variant="soft"
            @click="addNode('transition')"
          />
        </div>
      </div>
      <ProcedureCanvas
        ref="canvas"
        :graph="modelValue"
        :editable="true"
        @update:graph="emit('update:modelValue', $event)"
        @select-node="selectedId = $event"
      />
    </div>
    <aside class="space-y-5">
      <div class="surface p-5">
        <div class="flex items-center justify-between">
          <h3 class="font-semibold">Elemento seleccionado</h3>
          <UButton
            v-if="selected"
            icon="i-lucide-trash-2"
            color="error"
            variant="ghost"
            size="sm"
            aria-label="Eliminar elemento"
            @click="removeSelected"
          />
        </div>
        <p v-if="!selected" class="mt-3 text-sm text-slate-500">
          Selecciona un elemento para editarlo.
        </p>
        <div v-else class="mt-4 space-y-3">
          <UFormField label="Nombre"
            ><UInput
              :model-value="selected.label"
              class="w-full"
              @update:model-value="update({ label: String($event) })"
          /></UFormField>
          <UFormField v-if="selected.kind === 'transition'" label="Responsable">
            <USelect
              :model-value="selected.role || 'citizen'"
              :items="[
                { label: 'Ciudadano', value: 'citizen' },
                { label: 'Servidor público', value: 'servant' },
              ]"
              class="w-full"
              @update:model-value="update({ role: $event as 'citizen' | 'servant' })"
            />
          </UFormField>
        </div>
      </div>
      <div class="surface p-5">
        <h3 class="font-semibold">Inicio y final</h3>
        <div class="mt-4 grid gap-3">
          <UFormField label="Lugar inicial"
            ><USelect
              :model-value="modelValue.initialPlaceId"
              :items="places.map((node) => ({ label: node.label, value: node.id }))"
              class="w-full"
              @update:model-value="
                emit('update:modelValue', { ...modelValue, initialPlaceId: String($event) })
              "
          /></UFormField>
          <UFormField label="Lugar final"
            ><USelect
              :model-value="modelValue.finalPlaceId"
              :items="places.map((node) => ({ label: node.label, value: node.id }))"
              class="w-full"
              @update:model-value="
                emit('update:modelValue', { ...modelValue, finalPlaceId: String($event) })
              "
          /></UFormField>
        </div>
      </div>
    </aside>
  </div>
</template>
