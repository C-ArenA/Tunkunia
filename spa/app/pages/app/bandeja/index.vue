<script setup lang="ts">
import { listNotifications, listTasks, markNotificationRead } from "#shared/clientV1/sdk.gen";

const tab = ref<"pending" | "completed" | "notifications">("pending");
const { data: tasks, refresh: refreshTasks } = await useAsyncData("personal-tasks", async () => {
  const response = await listTasks({
    query: { status: tab.value === "completed" ? "completed" : "pending" },
  });
  return response.data ?? [];
});
const { data: notifications, refresh: refreshNotifications } = await useAsyncData(
  "personal-notifications",
  async () => {
    const response = await listNotifications();
    return response.data ?? [];
  },
);
watch(tab, () => {
  if (tab.value === "notifications") refreshNotifications();
  else refreshTasks();
});

async function read(id: number) {
  await markNotificationRead({ path: { id } });
  await refreshNotifications();
}
</script>

<template>
  <UDashboardPanel>
    <template #header><UDashboardNavbar title="Bandeja" /></template>
    <template #body>
      <div>
        <p class="eyebrow">Trabajo personal</p>
        <h1 class="page-title mt-2">Acciones y notificaciones</h1>
      </div>
      <UTabs
        v-model="tab"
        class="mt-6 max-w-xl"
        :items="[
          { label: 'Pendientes', value: 'pending' },
          { label: 'Completadas', value: 'completed' },
          { label: 'Notificaciones', value: 'notifications' },
        ]"
      />
      <div v-if="tab !== 'notifications'" class="mt-8 space-y-3">
        <UEmpty v-if="!tasks?.length" icon="i-lucide-inbox" title="No hay tareas en esta vista" />
        <NuxtLink
          v-for="task in tasks"
          :key="task.id"
          :to="`/app/casos/${task.caseId}`"
          class="surface block p-5 transition hover:border-emerald-300"
        >
          <div class="flex items-start justify-between gap-4">
            <div>
              <p class="font-semibold">{{ task.transitionLabel }}</p>
              <p class="mt-1 text-sm text-slate-500">Caso {{ task.caseId }}</p>
            </div>
            <UBadge
              :label="task.status === 'pending' ? 'Pendiente' : 'Completada'"
              variant="subtle"
            />
          </div>
        </NuxtLink>
      </div>
      <div v-else class="mt-8 space-y-3">
        <UEmpty
          v-if="!notifications?.length"
          icon="i-lucide-bell-off"
          title="No tienes notificaciones"
        />
        <div
          v-for="notice in notifications"
          :key="notice.id"
          class="surface flex items-center gap-4 p-5"
          :class="notice.readAt ? 'opacity-70' : ''"
        >
          <UIcon name="i-lucide-bell" class="size-5 text-emerald-700" />
          <NuxtLink :to="`/app/casos/${notice.caseId}`" class="flex-1"
            ><p class="font-semibold">{{ notice.title }}</p>
            <p class="mt-1 text-sm text-slate-500">
              Caso {{ notice.caseId }} · {{ new Date(notice.createdAt).toLocaleString("es-BO") }}
            </p></NuxtLink
          >
          <UButton
            v-if="!notice.readAt"
            label="Marcar leída"
            size="sm"
            color="neutral"
            variant="soft"
            @click="read(notice.id)"
          />
        </div>
      </div>
    </template>
  </UDashboardPanel>
</template>
