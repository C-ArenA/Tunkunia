<script setup lang="ts">
import { listTramitesQuery } from '#shared/client/@pinia/colada.gen'
import { useQuery } from '@pinia/colada'

definePageMeta({
  layout: 'empty'
})

const institutionName = 'Institución de Prueba'
const { data } = useQuery(listTramitesQuery)
</script>

<template>
  <div>
    <UPageHero
      title="Tunkunia"
      :headline="institutionName"
      reverse
      :description="`Plataforma de trámites en línea de la ${institutionName}, facilitando la interacción entre ciudadanos y entidades gubernamentales.`"
      orientation="horizontal"
      :links="[{
        label: 'Ingresar',
        to: 'https://ui.nuxt.com/docs/getting-started/installation/nuxt',
        trailingIcon: 'i-lucide-arrow-right',
        size: 'xl'
      }, {
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
          v-for="tramite in data?.data"
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
