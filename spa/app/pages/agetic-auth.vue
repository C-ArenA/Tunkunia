<script setup lang="ts">
import { listUsersQuery } from "#shared/clientV1/@pinia/colada.gen";

const { data: users } = useQuery(listUsersQuery);
</script>

<template>
  <div>Ciudadanía Digital</div>
  <a
    :href="`/callback?code=${user.id}`"
    v-for="user in users"
    :key="user.id"
    class="bg-blue-500 text-white px-4 py-2 rounded"
  >
    {{ user.id }} - {{ user.name }}
  </a>
</template>

<style scoped></style>
