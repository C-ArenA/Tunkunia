<script setup lang="ts">

interface Tramite {
  id: number
  name: string
  description: string
}
interface CollectionResponse<T> {
  data: T[]
  next_page_url: string
  previous_page_url: string
}

const { data } = await useFetch<CollectionResponse<Tramite>>('/api/v1/catalog/tramites', {
  method: 'GET',
  baseURL: 'http://localhost:8080',
  headers: {
    'Content-Type': 'application/json'
  }
})
const title = 'Trámites Disponibles'

</script>

<template>
  <div class="px-12 pt-8">
    <h1 class="text-3xl pb-4 font-bold tracking-tight text-gray-900 dark:text-white sm:text-4xl">
      {{ title }}
    </h1>
    <UTable :data="data?.data" class="flex-1" />
  </div>
</template>

<style scoped></style>