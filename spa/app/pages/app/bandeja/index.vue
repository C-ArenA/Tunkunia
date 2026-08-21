<script setup lang="ts">
const { state, completeTask } = useTunkuniaDemo();
const filter = ref<"pending" | "completed">("pending");
const selectedId = ref<string>();
const note = ref("");
const attachmentName = ref("");
const tasks = computed(() => state.value.tasks.filter((item) => item.status === filter.value));
const selected = computed(() => state.value.tasks.find((item) => item.id === selectedId.value));
function select(id: string) {
  selectedId.value = id;
  const task = state.value.tasks.find((item) => item.id === id);
  note.value = task?.note ?? "";
  attachmentName.value = task?.attachmentName ?? "";
}
function complete() {
  if (!selected.value) return;
  completeTask(selected.value.id, note.value, attachmentName.value || undefined);
  selectedId.value = undefined;
}
</script>
<template>
  <UDashboardPanel
    ><template #header
      ><UDashboardNavbar title="Bandeja"
        ><template #right
          ><UBadge
            color="warning"
            variant="subtle"
            label="Datos de demostración" /></template></UDashboardNavbar></template
    ><template #body
      ><div>
        <p class="eyebrow">Pendientes personales</p>
        <h1 class="page-title mt-2">Tareas que requieren tu atención</h1>
      </div>
      <UTabs
        v-model="filter"
        class="mt-6 max-w-sm"
        :items="[
          { label: 'Pendientes', value: 'pending' },
          { label: 'Completadas', value: 'completed' },
        ]" />
      <div class="mt-8 grid gap-5 xl:grid-cols-[1fr_380px]">
        <div class="space-y-3">
          <UEmpty
            v-if="!tasks.length"
            icon="i-lucide-inbox"
            title="No hay tareas en esta vista"
          /><button
            v-for="task in tasks"
            :key="task.id"
            class="surface block w-full p-5 text-left transition hover:border-emerald-300"
            @click="select(task.id)"
          >
            <div class="flex items-start justify-between gap-4">
              <div>
                <p class="font-semibold">{{ task.title }}</p>
                <p class="mt-1 text-sm text-slate-500">Caso {{ task.caseId }}</p>
              </div>
              <UBadge
                :color="
                  task.status === 'pending' && new Date(task.dueAt) < new Date()
                    ? 'error'
                    : 'neutral'
                "
                variant="subtle"
                :label="
                  task.status === 'completed'
                    ? 'Completada'
                    : new Date(task.dueAt) < new Date()
                      ? 'Vencida'
                      : 'Pendiente'
                "
              />
            </div>
            <p class="mt-3 line-clamp-2 text-sm text-slate-600">{{ task.description }}</p>
          </button>
        </div>
        <aside class="surface h-fit p-6 xl:sticky xl:top-6">
          <template v-if="selected"
            ><UBadge variant="subtle" :label="selected.caseId" />
            <h2 class="mt-4 text-xl font-semibold">{{ selected.title }}</h2>
            <p class="mt-3 text-sm leading-6 text-slate-600">{{ selected.description }}</p>
            <p class="mt-4 text-xs font-medium text-slate-500">
              Fecha límite: {{ new Date(selected.dueAt).toLocaleDateString("es-BO") }}
            </p>
            <template v-if="selected.status === 'pending'"
              ><UFormField label="Nota" class="mt-6"
                ><UTextarea
                  v-model="note"
                  class="w-full"
                  placeholder="Añade una observación" /></UFormField
              ><UFormField label="Adjunto (nombre demostrativo)" class="mt-4"
                ><UInput
                  v-model="attachmentName"
                  class="w-full"
                  placeholder="documento.pdf" /></UFormField
              ><UButton
                class="mt-6 w-full"
                label="Marcar como completada"
                icon="i-lucide-check"
                @click="complete"
            /></template>
            <div v-else class="mt-6 rounded-xl bg-emerald-50 p-4 text-sm text-emerald-800">
              <strong>Completada</strong>
              <p v-if="selected.note" class="mt-2">{{ selected.note }}</p>
            </div></template
          ><UEmpty
            v-else
            icon="i-lucide-mouse-pointer-2"
            title="Selecciona una tarea"
            description="Aquí verás su detalle y acciones."
          />
        </aside></div></template
  ></UDashboardPanel>
</template>
