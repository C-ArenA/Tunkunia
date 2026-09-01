<script setup lang="ts">
import type { NavigationMenuItem } from "@nuxt/ui";
import { getMeQuery, listTasksQuery } from "#shared/clientV1/@pinia/colada.gen";
const { data: me } = useQuery(getMeQuery);
const { data: pendingTasks } = useQuery(listTasksQuery({ query: { status: "pending" } }));
const pending = computed(() => pendingTasks.value?.length ?? 0);
const items = computed<NavigationMenuItem[]>(() => [
  { label: "Trámites", icon: "i-lucide-layout-grid", to: "/app" },
  { label: "Mis casos", icon: "i-lucide-folder-clock", to: "/app/casos" },
  {
    label: "Bandeja",
    icon: "i-lucide-inbox",
    badge: pending.value || undefined,
    to: "/app/bandeja",
  },
]);
</script>
<template>
  <UDashboardGroup class="bg-[#f7f8f5]">
    <UDashboardSidebar collapsible resizable :ui="{ footer: 'border-t border-default' }">
      <template #header="{ collapsed }">
        <div v-if="!collapsed" class="font-bold text-emerald-900">
          Tunkunia <span class="text-xs font-medium text-slate-500">Participantes</span>
        </div>
        <span v-else class="mx-auto font-bold text-emerald-800">T</span>
      </template>
      <template #default="{ collapsed }">
        <UNavigationMenu :collapsed="collapsed" :items="items" orientation="vertical" />
      </template>
      <template #footer="{ collapsed }">
        <div class="space-y-2">
          <UButton
            v-if="me?.roles.includes('admin')"
            to="/admin"
            icon="i-lucide-shield-check"
            :label="collapsed ? undefined : 'Administración'"
            color="neutral"
            variant="soft"
            class="w-full"
          />
          <UButton
            icon="i-lucide-user-round"
            :label="collapsed ? undefined : me?.name || 'Mi cuenta'"
            color="neutral"
            variant="ghost"
            class="w-full"
          />
        </div>
      </template>
    </UDashboardSidebar>

    <slot />
  </UDashboardGroup>
</template>
