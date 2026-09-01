<script setup lang="ts">
import { listUsers } from "#shared/clientV1/sdk.gen";
const search = ref("");
const { data: users } = await useAsyncData("admin-users", async () => {
  const response = await listUsers();
  if (response.error) throw response.error;
  return response.data ?? [];
});
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
          Concede el rol servidor a quienes puedan autoasignarse casos.
        </p>
      </div>
      <div class="surface mt-8 overflow-hidden">
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
            <UBadge v-for="role in item.roles" :key="role" :label="role" variant="subtle" />
          </div>
          <UButton
            :to="`/admin/usuarios/${item.id}`"
            label="Gestionar roles"
            color="neutral"
            variant="soft"
          />
        </div>
      </div>
    </template>
  </UDashboardPanel>
</template>
