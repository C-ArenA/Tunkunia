<script setup lang="ts">
import { fireTransition, getCase } from "#shared/clientV1/sdk.gen";

const route = useRoute();
const id = Number(route.params.id);
const firing = ref<string>();
const conflict = ref("");
const loadError = ref("");
const {
  data: item,
  status,
  refresh,
} = useAsyncData(`case-${id}`, async () => {
  loadError.value = "";
  const response = await getCase({ path: { id } });
  if (response.error || !response.data) {
    loadError.value = "No pudimos cargar el caso solicitado.";
    return null;
  }
  return response.data;
});
const actionable = computed(
  () => item.value?.availableTasks?.map((task) => task.transitionId) ?? [],
);
const activePlaces = computed(() =>
  Object.entries(item.value?.marking ?? {})
    .filter(([, tokens]) => tokens > 0)
    .map(([place]) => place),
);

async function fire(transitionId: string) {
  if (!item.value) return;
  firing.value = transitionId;
  conflict.value = "";
  const response = await fireTransition({
    path: { id, transitionId },
    body: { expectedRevision: item.value.revision },
  });
  firing.value = undefined;
  if (response.error) {
    conflict.value =
      "El caso cambió o la acción dejó de estar disponible. Se recargó el estado vigente.";
    await refresh();
    return;
  }
  if (response.data) item.value = response.data;
}
</script>

<template>
  <UDashboardPanel>
    <template #header
      ><UDashboardNavbar :title="item ? `Caso ${item.id}` : 'Caso'"
        ><template #left
          ><UButton
            to="/app/casos"
            icon="i-lucide-arrow-left"
            color="neutral"
            variant="ghost" /></template></UDashboardNavbar
    ></template>
    <template #body>
      <USkeleton v-if="status === 'pending'" class="h-96" />
      <UAlert
        v-else-if="loadError || !item"
        color="error"
        :title="loadError || 'Caso no encontrado'"
      />
      <template v-else>
        <UAlert v-if="conflict" class="mb-6" color="warning" :title="conflict" />
        <div class="flex flex-wrap items-center gap-3">
          <UBadge
            :label="item.status === 'active' ? 'En curso' : 'Concluido'"
            :color="item.status === 'active' ? 'primary' : 'neutral'"
          />
          <span class="font-mono text-sm text-slate-500"
            >Revisión {{ item.revision }} · versión {{ item.procedureVersion }}</span
          >
        </div>
        <h1 class="page-title mt-4">{{ item.tramiteName }}</h1>
        <section class="surface mt-8 p-6">
          <h2 class="text-xl font-semibold">Estado y acciones</h2>
          <p class="mt-2 text-sm text-slate-600">
            Las transiciones verdes son botones disponibles para ti; las amarillas están habilitadas
            para otro participante.
          </p>
          <ProcedureDiagram
            class="mt-6"
            :graph="item.definition"
            :active-node-ids="activePlaces"
            :enabled-transition-ids="item.enabledTransitions"
            :actionable-transition-ids="actionable"
            @transition="fire"
          />
          <div v-if="item.availableTasks?.length" class="mt-5 flex flex-wrap gap-3">
            <UButton
              v-for="task in item.availableTasks"
              :key="task.id"
              :label="task.transitionLabel"
              icon="i-lucide-play"
              :loading="firing === task.transitionId"
              @click="fire(task.transitionId)"
            />
          </div>
        </section>
        <section class="surface mt-8 p-6">
          <h2 class="text-xl font-semibold">Participantes</h2>
          <div class="mt-4 flex flex-wrap gap-3">
            <UBadge
              v-for="participant in item.participants"
              :key="participant.role"
              :label="`${participant.role === 'citizen' ? 'Ciudadano' : 'Servidor'}: ${participant.name}`"
              variant="subtle"
            />
          </div>
        </section>
        <section v-if="item.history" class="surface mt-8 p-6">
          <h2 class="text-xl font-semibold">Historial</h2>
          <UEmpty
            v-if="!item.history.length"
            class="mt-5"
            title="El caso todavía no tiene actuaciones"
          />
          <UTimeline
            v-else
            class="mt-6"
            :items="
              item.history.map((event) => ({
                title: event.transitionLabel,
                description: `${event.actorName} · ${new Date(event.occurredAt).toLocaleString('es-BO')}`,
                icon: 'i-lucide-check',
              }))
            "
          />
        </section>
      </template>
    </template>
  </UDashboardPanel>
</template>
