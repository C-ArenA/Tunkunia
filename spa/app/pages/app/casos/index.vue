<script setup lang="ts">
const { state } = useTunkuniaDemo();
const filter = ref<"all" | "active" | "completed">("all");
const cases = computed(() =>
  filter.value === "all"
    ? state.value.cases
    : state.value.cases.filter((item) => item.status === filter.value),
);
const tabs = [
  { label: "Todos", value: "all" },
  { label: "En curso", value: "active" },
  { label: "Concluidos", value: "completed" },
];
</script>
<template>
  <UDashboardPanel
    ><template #header><UDashboardNavbar title="Mis casos" /></template
    ><template #body
      ><div class="flex flex-col justify-between gap-5 md:flex-row md:items-end">
        <div>
          <p class="eyebrow">Seguimiento</p>
          <h1 class="page-title mt-2">Tus trámites en ejecución</h1>
          <p class="mt-3 text-slate-600">Consulta el avance y el historial de cada caso.</p>
        </div>
        <UTabs v-model="filter" :items="tabs" class="w-full md:w-auto" />
      </div>
      <UEmpty
        v-if="!cases.length"
        class="mt-10"
        icon="i-lucide-folder-open"
        title="No hay casos en esta vista" />
      <div v-else class="mt-8 space-y-4">
        <NuxtLink
          v-for="item in cases"
          :key="item.id"
          :to="`/app/casos/${item.id}`"
          class="surface flex flex-col gap-5 p-6 transition hover:border-emerald-300 md:flex-row md:items-center"
          ><div class="min-w-0 flex-1">
            <div class="flex flex-wrap items-center gap-2">
              <span class="font-mono text-xs text-slate-500">{{ item.id }}</span
              ><UBadge
                :color="item.status === 'active' ? 'primary' : 'neutral'"
                variant="subtle"
                :label="item.status === 'active' ? 'En curso' : 'Concluido'"
              />
            </div>
            <h2 class="mt-2 truncate text-lg font-semibold">{{ item.tramiteName }}</h2>
            <p class="mt-1 text-sm text-slate-500">
              Actualizado {{ new Date(item.updatedAt).toLocaleDateString("es-BO") }}
            </p>
          </div>
          <div class="w-full md:w-52">
            <div class="mb-2 flex justify-between text-xs">
              <span>Avance</span><span>{{ item.progress }}%</span>
            </div>
            <UProgress :model-value="item.progress" />
          </div>
          <UIcon name="i-lucide-chevron-right" class="size-5 text-slate-400"
        /></NuxtLink></div></template
  ></UDashboardPanel>
</template>
