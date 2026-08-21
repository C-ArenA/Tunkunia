<script setup lang="ts">
import { getTramiteQuery } from "#shared/clientV1/@pinia/colada.gen";
const route = useRoute();
const id = Number(route.params.id);
const { getGraph } = useTunkuniaDemo();
const { data: tramite, status, error } = useQuery(getTramiteQuery({ path: { id } }));
const graph = computed(() => getGraph(id));
</script>
<template>
  <UContainer class="py-10 md:py-16"
    ><UButton
      to="/"
      icon="i-lucide-arrow-left"
      label="Volver al catálogo"
      color="neutral"
      variant="ghost" />
    <div v-if="status === 'pending'" class="mt-8 space-y-4">
      <USkeleton class="h-12 w-2/3" /><USkeleton class="h-80" />
    </div>
    <UAlert
      v-else-if="error || !tramite"
      class="mt-8"
      color="error"
      title="Trámite no disponible"
      description="Puede que no exista o todavía no esté publicado." /><template v-else
      ><div class="mt-8 grid gap-8 lg:grid-cols-[1fr_300px]">
        <article>
          <UBadge color="primary" variant="subtle" :label="tramite.type" />
          <h1 class="page-title mt-4">{{ tramite.name }}</h1>
          <p class="mt-5 text-lg leading-8 text-slate-600">{{ tramite.description }}</p>
        </article>
        <aside class="surface p-6">
          <p class="text-sm font-semibold text-slate-900">¿Quieres realizar este trámite?</p>
          <p class="mt-2 text-sm text-slate-600">
            Ingresa con tu cuenta para iniciar y seguir tu caso.
          </p>
          <UButton
            to="/login"
            class="mt-5 w-full"
            label="Ingresar para comenzar"
            icon="i-lucide-log-in"
          />
        </aside>
      </div>
      <section class="surface mt-10 p-6 md:p-8">
        <p class="eyebrow">Procedimiento</p>
        <h2 class="mt-2 text-2xl font-semibold">Cómo se procesa</h2>
        <p class="mt-3 max-w-3xl text-slate-600">
          {{
            tramite.procedureDescription ||
            "El procedimiento se encuentra representado en el siguiente diagrama."
          }}
        </p>
        <ProcedureDiagram class="mt-7" :graph="graph" /></section></template
  ></UContainer>
</template>
