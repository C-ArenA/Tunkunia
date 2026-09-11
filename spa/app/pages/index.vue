<script setup lang="ts">
import { getMeQuery, listTramitesQuery } from "#shared/clientV1/@pinia/colada.gen";

const { state } = useTunkuniaDemo();
const { data: me } = useQuery(getMeQuery);
const {
  data: tramites,
  status,
  error,
} = useQuery(listTramitesQuery({ query: { status: "published", limit: 100 } }));
</script>

<template>
  <div class="bg-white">
    <UContainer
      class="grid min-h-[calc(100vh-0.25rem)] gap-10 py-10 md:grid-cols-[minmax(16rem,0.72fr)_minmax(0,1.28fr)] md:items-center md:gap-16 md:py-16"
    >
      <header class="flex flex-col items-start md:sticky md:top-20">
        <div
          class="grid size-14 place-items-center rounded-2xl bg-emerald-800 text-sm font-bold text-white"
        >
          {{ state.institution.acronym }}
        </div>
        <p class="mt-7 text-sm font-semibold tracking-wide text-emerald-700">Tunkunia</p>
        <h1 class="mt-2 text-3xl font-bold tracking-tight text-slate-950 md:text-4xl">
          {{ state.institution.name }}
        </h1>
        <p class="mt-4 max-w-md leading-7 text-slate-600">
          {{ state.institution.description }}
        </p>
        <UButton
          v-if="!me"
          to="/login"
          external
          class="mt-8"
          size="xl"
          label="Ingresar"
          icon="i-lucide-log-in"
        />
        <UButton
          v-else
          to="/app"
          class="mt-8"
          size="xl"
          label="Ir a mi cuenta"
          icon="i-lucide-arrow-right"
        />
      </header>

      <main id="tramites" class="min-w-0 md:max-h-[calc(100vh-8rem)] md:overflow-y-auto md:pr-3">
        <div class="border-b border-slate-200 pb-5">
          <h2 class="text-2xl font-bold tracking-tight text-slate-950">Trámites disponibles</h2>
          <p class="mt-2 text-slate-600">
            Consulta la información, los requisitos y el procedimiento de cada trámite.
          </p>
        </div>

        <div v-if="status === 'pending'" class="mt-6 grid gap-4">
          <USkeleton v-for="n in 4" :key="n" class="h-32 rounded-xl" />
        </div>
        <UAlert
          v-else-if="error"
          class="mt-6"
          color="error"
          title="No pudimos cargar los trámites"
          description="Vuelve a intentarlo en unos minutos."
          icon="i-lucide-circle-alert"
        />
        <UEmpty
          v-else-if="!tramites?.data.length"
          class="mt-6"
          icon="i-lucide-files"
          title="No hay trámites publicados"
          description="Los trámites disponibles aparecerán aquí."
        />
        <ul v-else class="divide-y divide-slate-200">
          <li v-for="item in tramites.data" :key="item.id">
            <NuxtLink
              :to="`/tramites/${item.id}`"
              class="group flex items-start justify-between gap-5 py-6"
            >
              <div>
                <h3 class="text-lg font-semibold text-slate-900 group-hover:text-emerald-700">
                  {{ item.name }}
                </h3>
                <p class="mt-2 line-clamp-2 leading-6 text-slate-600">
                  {{ item.description }}
                </p>
                <p class="mt-3 text-sm font-semibold text-emerald-700">
                  Ver información y procedimiento
                </p>
              </div>
              <UIcon
                name="i-lucide-chevron-right"
                class="mt-1 size-5 shrink-0 text-slate-400 transition group-hover:translate-x-1 group-hover:text-emerald-700"
              />
            </NuxtLink>
          </li>
        </ul>
      </main>
    </UContainer>
  </div>
</template>
