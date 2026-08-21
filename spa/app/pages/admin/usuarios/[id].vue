<script setup lang="ts">
const route = useRoute();
const { state, toggleAdmin } = useTunkuniaDemo();
const id = Number(route.params.id);
const user = computed(() => state.value.users.find((u) => u.id === id));
const cases = computed(() => state.value.cases.filter((c) => c.participantId === id));
</script>
<template>
  <UDashboardPanel
    ><template #header
      ><UDashboardNavbar title="Detalle de usuario"
        ><template #left
          ><UButton
            to="/admin/usuarios"
            icon="i-lucide-arrow-left"
            color="neutral"
            variant="ghost" /></template></UDashboardNavbar></template
    ><template #body
      ><UAlert v-if="!user" color="error" title="Usuario no encontrado" /><template v-else
        ><div class="surface flex flex-col gap-6 p-6 md:flex-row md:items-center">
          <span
            class="grid size-16 place-items-center rounded-2xl bg-emerald-50 text-xl font-bold text-emerald-700"
            >{{
              user.name
                .split(" ")
                .map((n) => n[0])
                .join("")
                .slice(0, 2)
            }}</span
          >
          <div class="flex-1">
            <h1 class="text-2xl font-semibold">{{ user.name }}</h1>
            <p class="mt-1 text-slate-500">{{ user.email }}</p>
          </div>
          <UButton
            :label="
              user.roles.includes('admin') ? 'Revocar administración' : 'Conceder administración'
            "
            :color="user.roles.includes('admin') ? 'error' : 'primary'"
            variant="soft"
            @click="toggleAdmin(user.id)"
          />
        </div>
        <section class="mt-8">
          <h2 class="text-xl font-semibold">Casos del usuario</h2>
          <UEmpty
            v-if="!cases.length"
            class="mt-5"
            title="Este usuario todavía no tiene casos"
            icon="i-lucide-folder-open"
          />
          <div v-else class="mt-5 grid gap-4 lg:grid-cols-2">
            <div v-for="item in cases" :key="item.id" class="surface p-5">
              <div class="flex justify-between">
                <span class="font-mono text-xs text-slate-500">{{ item.id }}</span
                ><UBadge
                  :label="item.status === 'active' ? 'En curso' : 'Concluido'"
                  variant="subtle"
                />
              </div>
              <p class="mt-3 font-semibold">{{ item.tramiteName }}</p>
              <UProgress class="mt-4" :model-value="item.progress" />
            </div>
          </div></section></template></template
  ></UDashboardPanel>
</template>
