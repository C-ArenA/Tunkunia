<script setup lang="ts">
const { state } = useTunkuniaDemo();
const search = ref("");
const users = computed(() =>
  state.value.users.filter((u) =>
    `${u.name} ${u.email}`.toLowerCase().includes(search.value.toLowerCase()),
  ),
);
</script>
<template>
  <UDashboardPanel
    ><template #header
      ><UDashboardNavbar title="Usuarios"
        ><template #right
          ><UInput
            v-model="search"
            icon="i-lucide-search"
            placeholder="Buscar usuario" /></template></UDashboardNavbar></template
    ><template #body
      ><div>
        <p class="eyebrow">Participantes</p>
        <h1 class="page-title mt-2">Gestión de usuarios</h1>
        <p class="mt-3 text-slate-600">Consulta roles y los casos asociados a cada participante.</p>
      </div>
      <div class="surface mt-8 overflow-hidden">
        <div
          v-for="user in users"
          :key="user.id"
          class="flex flex-col gap-4 border-b border-slate-100 p-5 last:border-0 sm:flex-row sm:items-center"
        >
          <span
            class="grid size-11 shrink-0 place-items-center rounded-full bg-emerald-50 font-semibold text-emerald-700"
            >{{
              user.name
                .split(" ")
                .map((n) => n[0])
                .join("")
                .slice(0, 2)
            }}</span
          >
          <div class="min-w-0 flex-1">
            <p class="font-semibold">{{ user.name }}</p>
            <p class="truncate text-sm text-slate-500">{{ user.email }}</p>
          </div>
          <div class="flex flex-wrap gap-2">
            <UBadge v-for="role in user.roles" :key="role" variant="subtle" :label="role" />
          </div>
          <UButton
            :to="`/admin/usuarios/${user.id}`"
            label="Ver detalle"
            color="neutral"
            variant="soft"
          />
        </div></div></template
  ></UDashboardPanel>
</template>
