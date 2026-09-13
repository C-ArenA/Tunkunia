<script setup lang="ts">
import { listUsersQuery } from "#shared/clientV1/@pinia/colada.gen";
const search = ref("");
const { data: users, status, error } = useQuery(listUsersQuery);
const visible = computed(() =>
  (users.value ?? []).filter((u) =>
    `${u.name} ${u.email}`.toLowerCase().includes(search.value.toLowerCase()),
  ),
);
</script>
<template>
  <UDashboardPanel>
    <template #header
      ><UDashboardNavbar title="Usuarios"
        ><template #right
          ><UInput
            v-model="search"
            icon="i-lucide-search"
            placeholder="Buscar usuario" /></template></UDashboardNavbar
    ></template>
    <template #body>
      <div>
        <p class="eyebrow">Participantes</p>
        <h1 class="page-title mt-2">Gestión de usuarios</h1>
        <p class="mt-3 text-slate-600">
          Concede acceso institucional a quienes administran el sistema o atienden casos.
        </p>
      </div>
      <USkeleton v-if="status === 'pending'" class="mt-8 h-64" />
      <UAlert v-else-if="error" class="mt-8" color="error" title="No pudimos cargar los usuarios" />
      <UEmpty
        v-else-if="!visible.length"
        class="mt-8"
        icon="i-lucide-users"
        title="No hay usuarios en esta vista"
      />
      <div v-else class="surface mt-8 overflow-hidden">
        <div
          v-for="item in visible"
          :key="item.id"
          class="flex items-center gap-4 border-b border-slate-100 p-5 last:border-0"
        >
          <div class="min-w-0 flex-1">
            <p class="font-semibold">{{ item.name }}</p>
            <p class="truncate text-sm text-slate-500">{{ item.email }}</p>
          </div>
          <div class="flex gap-2">
            <UBadge label="Ciudadano" color="neutral" variant="subtle" />
            <UBadge v-if="item.isAdmin" label="Administrador" variant="subtle" />
            <UBadge v-if="item.isPublicServant" label="Servidor público" variant="subtle" />
          </div>
          <UButton
            :to="`/admin/usuarios/${item.id}`"
            label="Gestionar acceso"
            color="neutral"
            variant="soft"
          />
        </div>
      </div>
    </template>
  </UDashboardPanel>
</template>
