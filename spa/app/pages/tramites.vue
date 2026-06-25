<script setup lang="ts">
import { listTramitesQuery } from '#shared/client/@pinia/colada.gen'
import { useQuery } from '@pinia/colada'

const { data } = useQuery(listTramitesQuery)
const title = 'Trámites Disponibles'
</script>

<template>
  <UPageSection
    id="tramites"
    :title="title"
    description="Explora los trámites disponibles en nuestra plataforma."
  >
    <UTable
      :data="data?.data"
      :columns="[
        {
          accessorKey: 'id',
          header: 'ID'
        },
        {
          accessorKey: 'name',
          header: 'Trámite'
        },
        {
          accessorKey: 'description',
          header: 'Descripción'
        }
      ]"
    />
  </UPageSection>
</template>
