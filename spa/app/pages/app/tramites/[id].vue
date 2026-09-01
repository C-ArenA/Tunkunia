<script setup lang="ts">
import { getPublishedProcedureQuery, getTramiteQuery } from "#shared/clientV1/@pinia/colada.gen";
import { startCase } from "#shared/clientV1/sdk.gen";
const route = useRoute();
const id = Number(route.params.id);
const { data: tramite, status, error } = useQuery(getTramiteQuery({ path: { id } }));
const { data: procedure } = useQuery(getPublishedProcedureQuery({ path: { id } }));
const starting = ref(false);
async function begin() {
  if (!tramite.value) return;
  starting.value = true;
  const response = await startCase({ path: { id } });
  starting.value = false;
  if (response.data) await navigateTo(`/app/casos/${response.data.id}`);
}
</script>
<template>
  <UDashboardPanel
    ><template #header
      ><UDashboardNavbar title="Detalle del trámite"
        ><template #left
          ><UButton
            to="/app"
            icon="i-lucide-arrow-left"
            color="neutral"
            variant="ghost" /></template></UDashboardNavbar></template
    ><template #body
      ><USkeleton v-if="status === 'pending'" class="h-96" /><UAlert
        v-else-if="error || !tramite"
        color="error"
        title="No pudimos abrir este trámite" /><template v-else
        ><div class="grid gap-8 xl:grid-cols-[1fr_300px]">
          <div>
            <UBadge :label="tramite.type" variant="subtle" />
            <h1 class="page-title mt-4">{{ tramite.name }}</h1>
            <p class="mt-4 text-lg text-slate-600">{{ tramite.description }}</p>
          </div>
          <div class="surface p-6">
            <p class="font-semibold">Iniciar un caso</p>
            <p class="mt-2 text-sm text-slate-600">
              Crearemos un expediente y la primera tarea en tu bandeja.
            </p>
            <UButton
              class="mt-5 w-full"
              label="Iniciar trámite"
              icon="i-lucide-play"
              :loading="starting"
              @click="begin"
            />
          </div>
        </div>
        <section class="surface mt-8 p-6">
          <h2 class="text-xl font-semibold">Procedimiento</h2>
          <p class="mt-3 text-slate-600">{{ tramite.procedureDescription }}</p>
          <ProcedureDiagram
            v-if="procedure"
            class="mt-6"
            :graph="procedure.definition"
          /></section></template></template
  ></UDashboardPanel>
</template>
