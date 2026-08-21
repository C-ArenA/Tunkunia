<script setup lang="ts">
import { listTramitesQuery } from "#shared/clientV1/@pinia/colada.gen";
const { state } = useTunkuniaDemo();
const { data: tramites } = useQuery(listTramitesQuery({ query: { limit: 100 } }));
const cards = computed(() => [
  {
    label: "Trámites",
    value: tramites.value?.data.length ?? 0,
    icon: "i-lucide-workflow",
    to: "/admin/tramites",
  },
  {
    label: "Usuarios",
    value: state.value.users.length,
    icon: "i-lucide-users",
    to: "/admin/usuarios",
  },
  {
    label: "Casos activos",
    value: state.value.cases.filter((c) => c.status === "active").length,
    icon: "i-lucide-folder-clock",
    to: "/admin/usuarios",
  },
  {
    label: "Tareas pendientes",
    value: state.value.tasks.filter((t) => t.status === "pending").length,
    icon: "i-lucide-inbox",
    to: "/app/bandeja",
  },
]);
</script>
<template>
  <UDashboardPanel
    ><template #header
      ><UDashboardNavbar title="Administración"
        ><template #right
          ><UBadge
            color="warning"
            variant="subtle"
            label="Datos de demostración" /></template></UDashboardNavbar></template
    ><template #body
      ><div>
        <p class="eyebrow">Panel institucional</p>
        <h1 class="page-title mt-2">Resumen de operación</h1>
        <p class="mt-3 text-slate-600">
          Gestiona el catálogo, los participantes y la identidad de la institución.
        </p>
      </div>
      <div class="mt-8 grid gap-5 sm:grid-cols-2 xl:grid-cols-4">
        <NuxtLink
          v-for="card in cards"
          :key="card.label"
          :to="card.to"
          class="surface p-6 transition hover:border-emerald-300"
          ><div class="flex items-center justify-between">
            <span class="grid size-10 place-items-center rounded-xl bg-slate-100"
              ><UIcon :name="card.icon" class="size-5" /></span
            ><UIcon name="i-lucide-arrow-up-right" class="text-slate-400" />
          </div>
          <p class="mt-6 text-3xl font-bold">{{ card.value }}</p>
          <p class="mt-1 text-sm text-slate-500">{{ card.label }}</p></NuxtLink
        >
      </div>
      <div class="surface mt-8 p-6">
        <h2 class="text-xl font-semibold">Acciones frecuentes</h2>
        <div class="mt-5 flex flex-wrap gap-3">
          <UButton to="/admin/tramites/nuevo" icon="i-lucide-plus" label="Crear trámite" /><UButton
            to="/admin/institucion"
            icon="i-lucide-landmark"
            label="Editar institución"
            color="neutral"
            variant="soft"
          /><UButton
            to="/admin/usuarios"
            icon="i-lucide-users"
            label="Revisar usuarios"
            color="neutral"
            variant="soft"
          />
        </div></div></template
  ></UDashboardPanel>
</template>
