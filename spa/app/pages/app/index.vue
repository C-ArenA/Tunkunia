<script setup lang="ts">
import { listTramitesQuery } from "#shared/clientV1/@pinia/colada.gen";
const search = ref("");
const {
  data: tramites,
  status,
  error,
} = useQuery(listTramitesQuery({ query: { status: "published", limit: 100 } }));
const visible = computed(() =>
  (tramites.value?.data ?? []).filter((item) =>
    item.name.toLocaleLowerCase().includes(search.value.toLocaleLowerCase()),
  ),
);
</script>
<template>
  <UDashboardPanel
    ><template #header
      ><UDashboardNavbar title="Trámites"
        ><template #right
          ><UInput
            v-model="search"
            icon="i-lucide-search"
            placeholder="Buscar trámite" /></template></UDashboardNavbar></template
    ><template #body
      ><div>
        <p class="eyebrow">Catálogo institucional</p>
        <h1 class="page-title mt-2">¿Qué necesitas hacer?</h1>
        <p class="mt-3 text-slate-600">Consulta un trámite e inicia un caso cuando estés listo.</p>
      </div>
      <div v-if="status === 'pending'" class="mt-8 grid gap-5 lg:grid-cols-2">
        <USkeleton v-for="n in 4" :key="n" class="h-40" />
      </div>
      <UAlert
        v-else-if="error"
        class="mt-8"
        color="error"
        title="No pudimos cargar el catálogo"
      /><UEmpty
        v-else-if="!visible.length"
        class="mt-8"
        title="No hay resultados"
        icon="i-lucide-search-x"
      />
      <div v-else class="mt-8 grid gap-5 lg:grid-cols-2">
        <NuxtLink
          v-for="item in visible"
          :key="item.id"
          :to="`/app/tramites/${item.id}`"
          class="surface p-6 transition hover:border-emerald-300"
          ><div class="flex gap-4">
            <span
              class="grid size-11 shrink-0 place-items-center rounded-xl bg-emerald-50 text-emerald-700"
              ><UIcon name="i-lucide-file-text" class="size-5"
            /></span>
            <div>
              <h2 class="text-lg font-semibold">{{ item.name }}</h2>
              <p class="mt-2 line-clamp-2 text-sm text-slate-600">{{ item.description }}</p>
              <p class="mt-4 text-sm font-semibold text-emerald-700">Ver detalle</p>
            </div>
          </div></NuxtLink
        >
      </div></template
    ></UDashboardPanel
  >
</template>
