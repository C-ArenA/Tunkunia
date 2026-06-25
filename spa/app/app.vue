<script setup>
const title = 'Tunkunia'
const description = 'Plataforma de trámites en línea, facilitando la interacción entre ciudadanos y entidades gubernamentales.'

useSeoMeta({
  title,
  description,
  ogTitle: title,
  ogDescription: description
})
</script>

<template>
  <NuxtLayout>
    <NuxtPage />
  </NuxtLayout>
</template>
