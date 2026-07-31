<script setup lang="ts">
import { listTramitesQuery, getMeQuery } from '#shared/client/@pinia/colada.gen'
import { useQuery } from '@pinia/colada'

definePageMeta({
  layout: 'empty'
})

const institutionName = 'Institución de Prueba'
const { data: tramitesData } = useQuery(listTramitesQuery)
const { data: userData, isPending } = useQuery(getMeQuery)
const isLoggedIn = computed(() => !!userData.value)
</script>

<template>
  <div>
    <div class="flex justify-end p-4">
      <UButton
        v-if="!isPending && !isLoggedIn"
        to="/login"
        external
        color="primary"
        variant="solid"
        size="lg"
      >
        Ingresar
      </UButton>
      <UButton
        v-if="!isPending && isLoggedIn"
        to="/oidc-logout"
        external
        color="neutral"
        variant="outline"
        size="lg"
      >
        Cerrar sesión
      </UButton>
    </div>
    <UPageHero
      title="Tunkunia"
      :headline="institutionName"
      reverse
      :description="`Plataforma de trámites en línea de la ${institutionName}, facilitando la interacción entre ciudadanos y entidades gubernamentales.`"
      orientation="horizontal"
      :links="[{
        label: 'Ver trámites disponibles',
        to: '/tramites',
        icon: 'i-simple-icons-amazonredshift',
        size: 'xl',
        color: 'neutral',
        variant: 'subtle'
      }]"
    >
      <UMarquee
        pause-on-hover
        orientation="vertical"
        :repeat="4"
        class="w-full h-96"
      >
        <UCard
          v-for="tramite in tramitesData?.data"
          :key="tramite.id"
          variant="subtle"
          :title="tramite.name"
          :description="tramite.description || 'Sin descripción disponible'"
          class="w-full"
        >
          <p>Paso 1: Requisitos</p>
          <template #footer>
            <UButton
              to="#"
              color="primary"
              variant="solid"
              size="sm"
            >
              Iniciar trámite
            </UButton>
          </template>
        </UCard>
      </UMarquee>
    </UPageHero>
  </div>
</template>
