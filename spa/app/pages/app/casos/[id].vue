<script setup lang="ts">
const route = useRoute();
const { state, getGraph } = useTunkuniaDemo();
const item = computed(() => state.value.cases.find((entry) => entry.id === route.params.id));
</script>
<template>
  <UDashboardPanel
    ><template #header
      ><UDashboardNavbar :title="item?.id || 'Caso'"
        ><template #left
          ><UButton
            to="/app/casos"
            icon="i-lucide-arrow-left"
            color="neutral"
            variant="ghost" /></template></UDashboardNavbar></template
    ><template #body
      ><UAlert v-if="!item" color="error" title="Caso no encontrado" /><template v-else
        ><div class="grid gap-6 lg:grid-cols-[1fr_280px]">
          <div>
            <div class="flex items-center gap-3">
              <UBadge
                :label="item.status === 'active' ? 'En curso' : 'Concluido'"
                :color="item.status === 'active' ? 'primary' : 'neutral'"
              /><span class="font-mono text-sm text-slate-500">{{ item.id }}</span>
            </div>
            <h1 class="page-title mt-4">{{ item.tramiteName }}</h1>
          </div>
          <div class="surface p-5">
            <div class="flex justify-between text-sm">
              <span>Avance del caso</span><strong>{{ item.progress }}%</strong>
            </div>
            <UProgress class="mt-3" :model-value="item.progress" />
          </div>
        </div>
        <section class="surface mt-8 p-6">
          <h2 class="text-xl font-semibold">Estado del procedimiento</h2>
          <p class="mt-2 text-sm text-slate-600">
            Los elementos resaltados muestran la ubicación informativa actual del caso.
          </p>
          <ProcedureDiagram
            class="mt-6"
            :graph="getGraph(item.tramiteId)"
            :active-node-ids="item.activeNodeIds"
          />
        </section>
        <section class="surface mt-8 p-6">
          <h2 class="text-xl font-semibold">Historial</h2>
          <UTimeline
            class="mt-6"
            :items="
              item.history.map((event) => ({
                title: event.label,
                description: new Date(event.at).toLocaleString('es-BO'),
                icon: 'i-lucide-check',
              }))
            "
          /></section></template></template
  ></UDashboardPanel>
</template>
