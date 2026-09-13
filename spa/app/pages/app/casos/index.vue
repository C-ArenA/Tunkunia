<script setup lang="ts">
import { getMeQuery } from "#shared/clientV1/@pinia/colada.gen";
import { listCasesQuery } from "#shared/clientV1/@pinia/colada.gen";
import { claimCase } from "#shared/clientV1/sdk.gen";

const { data: me } = useQuery(getMeQuery);
const view = ref<"mine" | "unassigned">("mine");
const claiming = ref<number>();
const actionError = ref("");
const loadError = ref("");
const casesQuery = useQuery(() => listCasesQuery({ query: { scope: view.value } }));
const cases = computed(() => casesQuery.data.value ?? []);
const status = computed(() => casesQuery.status.value);
watch(casesQuery.error, (value) => {
  loadError.value = value ? "No pudimos cargar los casos. Intenta nuevamente." : "";
});

async function claim(id: number) {
  claiming.value = id;
  actionError.value = "";
  const response = await claimCase({ path: { id } });
  claiming.value = undefined;
  if (response.error) {
    actionError.value = "Otro servidor tomó el caso o ya no requiere atención.";
    await casesQuery.refresh();
    return;
  }
  await navigateTo(`/app/casos/${id}`);
}
</script>

<template>
  <UDashboardPanel>
    <template #header><UDashboardNavbar title="Casos" /></template>
    <template #body>
      <div class="flex flex-col justify-between gap-5 md:flex-row md:items-end">
        <div>
          <p class="eyebrow">Seguimiento</p>
          <h1 class="page-title mt-2">Trámites en ejecución</h1>
          <p class="mt-3 text-slate-600">El estado corresponde al marcado vigente de cada caso.</p>
        </div>
        <UTabs
          v-model="view"
          :items="[
            { label: 'Mis casos', value: 'mine' },
            ...(me?.isPublicServant ? [{ label: 'No asignados', value: 'unassigned' }] : []),
          ]"
        />
      </div>
      <UAlert v-if="actionError" class="mt-6" color="warning" :title="actionError" />
      <UAlert v-if="loadError" class="mt-6" color="error" :title="loadError" />
      <div v-if="status === 'pending'" class="mt-8 space-y-4">
        <USkeleton v-for="n in 3" :key="n" class="h-28" />
      </div>
      <UEmpty
        v-else-if="!cases?.length"
        class="mt-10"
        icon="i-lucide-folder-open"
        title="No hay casos en esta vista"
      />
      <div v-else class="mt-8 space-y-4">
        <div
          v-for="item in cases"
          :key="item.id"
          class="surface flex flex-col gap-5 p-6 md:flex-row md:items-center"
        >
          <NuxtLink v-if="view === 'mine'" :to="`/app/casos/${item.id}`" class="min-w-0 flex-1">
            <div class="flex items-center gap-2">
              <span class="font-mono text-xs text-slate-500">Caso {{ item.id }}</span>
              <UBadge
                :label="item.status === 'active' ? 'En curso' : 'Concluido'"
                variant="subtle"
              />
            </div>
            <h2 class="mt-2 text-lg font-semibold">{{ item.tramiteName }}</h2>
            <p class="mt-1 text-sm text-slate-500">
              Actualizado {{ new Date(item.updatedAt).toLocaleString("es-BO") }}
            </p>
          </NuxtLink>
          <div v-else class="min-w-0 flex-1">
            <div class="flex items-center gap-2">
              <span class="font-mono text-xs text-slate-500">Caso {{ item.id }}</span>
              <UBadge
                :label="item.status === 'active' ? 'En curso' : 'Concluido'"
                variant="subtle"
              />
            </div>
            <h2 class="mt-2 text-lg font-semibold">{{ item.tramiteName }}</h2>
            <p class="mt-1 text-sm text-slate-500">
              Actualizado {{ new Date(item.updatedAt).toLocaleString("es-BO") }}
            </p>
          </div>
          <UButton
            v-if="view === 'unassigned'"
            label="Tomar caso"
            icon="i-lucide-hand"
            :loading="claiming === item.id"
            @click="claim(item.id)"
          />
          <UIcon v-else name="i-lucide-chevron-right" class="size-5 text-slate-400" />
        </div>
      </div>
    </template>
  </UDashboardPanel>
</template>
