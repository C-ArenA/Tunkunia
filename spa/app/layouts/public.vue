<script setup lang="ts">
const { institution } = useInstitution();
const route = useRoute();
const isHomepage = computed(() => route.path === "/");
</script>

<template>
  <div class="min-h-screen bg-[#f7f8f5]">
    <div class="tricolor sticky top-0 z-50" />
    <header v-if="!isHomepage" class="border-b border-slate-200 bg-white/90 backdrop-blur">
      <UContainer class="flex h-18 items-center justify-between gap-6">
        <NuxtLink to="/" class="flex items-center gap-3 font-bold text-slate-900">
          <span
            class="grid size-10 place-items-center rounded-xl bg-emerald-800 text-sm text-white"
            >{{ institution.acronym }}</span
          >
          <span class="hidden sm:block">{{ institution.name }}</span>
        </NuxtLink>
        <nav class="flex items-center gap-2" aria-label="Navegación principal">
          <UButton to="/#tramites" label="Trámites" color="neutral" variant="ghost" />
          <UButton to="/login" label="Ingresar" icon="i-lucide-log-in" color="primary" />
        </nav>
      </UContainer>
    </header>
    <main><slot /></main>
    <footer
      class="border-t border-slate-200 bg-slate-950 py-12 text-slate-300"
      :class="{ 'mt-16': !isHomepage }"
    >
      <UContainer class="grid gap-8 md:grid-cols-3">
        <div>
          <p class="font-semibold text-white">{{ institution.name }}</p>
          <p v-if="institution.description" class="mt-2 text-sm">{{ institution.description }}</p>
        </div>
        <div>
          <p class="text-sm font-semibold text-white">Contacto</p>
          <p class="mt-2 text-sm">
            <span v-if="institution.email">{{ institution.email }}<br /></span
            >{{ institution.phone }}
          </p>
        </div>
        <div>
          <p class="text-sm font-semibold text-white">Atención</p>
          <p class="mt-2 text-sm">{{ institution.address }}</p>
        </div>
      </UContainer>
    </footer>
  </div>
</template>
<style scoped>
.tricolor {
  height: 5px;
  background: linear-gradient(90deg, #d52b1e 0 33.33%, #f9e300 33.33% 66.66%, #007934 66.66%);
}
</style>
