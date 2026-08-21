<script setup lang="ts">
import { deleteTramite, listTramites } from "#shared/clientV1/sdk.gen";
import type { TramiteStatus } from "#shared/clientV1/types.gen";
const statusFilter = ref<"all" | TramiteStatus>("all");
const search = ref("");
const deleting = ref<number>();
const {
  data: collection,
  status,
  error,
  refresh,
} = await useAsyncData(
  "admin-tramites",
  async () => {
    const response = await listTramites({
      query: { status: statusFilter.value === "all" ? undefined : statusFilter.value, limit: 100 },
    });
    if (response.error) throw response.error;
    return response.data;
  },
  { watch: [statusFilter] },
);
const visible = computed(() =>
  (collection.value?.data ?? []).filter((t) =>
    t.name.toLowerCase().includes(search.value.toLowerCase()),
  ),
);
async function remove(id: number) {
  if (!confirm("¿Eliminar este trámite? Esta acción no se puede deshacer.")) return;
  deleting.value = id;
  const response = await deleteTramite({ path: { id } });
  deleting.value = undefined;
  if (!response.error) await refresh();
}
</script>
<template>
  <UDashboardPanel
    ><template #header
      ><UDashboardNavbar title="Trámites"
        ><template #right
          ><UButton
            to="/admin/tramites/nuevo"
            label="Crear trámite"
            icon="i-lucide-plus" /></template></UDashboardNavbar></template
    ><template #body
      ><div class="flex flex-col justify-between gap-6 xl:flex-row xl:items-end">
        <div>
          <p class="eyebrow">Catálogo</p>
          <h1 class="page-title mt-2">Gestión de trámites</h1>
          <p class="mt-3 text-slate-600">
            Crea, publica, archiva y edita procedimientos institucionales.
          </p>
        </div>
        <div class="flex flex-col gap-3 sm:flex-row">
          <USelect
            v-model="statusFilter"
            :items="[
              { label: 'Todos los estados', value: 'all' },
              { label: 'Borradores', value: 'draft' },
              { label: 'Publicados', value: 'published' },
              { label: 'Archivados', value: 'archived' },
            ]"
            class="w-48"
          /><UInput v-model="search" icon="i-lucide-search" placeholder="Buscar trámite" />
        </div>
      </div>
      <USkeleton v-if="status === 'pending'" class="mt-8 h-72" /><UAlert
        v-else-if="error"
        class="mt-8"
        color="error"
        title="No pudimos cargar los trámites" /><UEmpty
        v-else-if="!visible.length"
        class="mt-8"
        icon="i-lucide-workflow"
        title="No hay trámites en esta vista" />
      <div v-else class="surface mt-8 overflow-hidden">
        <div
          v-for="item in visible"
          :key="item.id"
          class="flex flex-col gap-4 border-b border-slate-100 p-5 last:border-0 md:flex-row md:items-center"
        >
          <span
            class="grid size-11 shrink-0 place-items-center rounded-xl bg-slate-100 text-slate-600"
            ><UIcon name="i-lucide-workflow" class="size-5"
          /></span>
          <div class="min-w-0 flex-1">
            <p class="font-semibold">{{ item.name }}</p>
            <p class="mt-1 truncate text-sm text-slate-500">{{ item.description }}</p>
          </div>
          <UButton
            :to="`/admin/tramites/${item.id}`"
            label="Editar"
            icon="i-lucide-pencil"
            color="neutral"
            variant="soft"
          /><UButton
            icon="i-lucide-trash-2"
            aria-label="Eliminar trámite"
            color="error"
            variant="ghost"
            :loading="deleting === item.id"
            @click="remove(item.id)"
          />
        </div></div></template
  ></UDashboardPanel>
</template>
