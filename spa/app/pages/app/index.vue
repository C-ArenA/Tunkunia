<script setup lang="ts">
import { listTramitesQuery } from "#shared/clientV1/@pinia/colada.gen";
const { data: tramites } = useQuery(listTramitesQuery);
</script>

<template>
  <div>
    <UTable :data="tramites?.data" />
  </div>
</template>

<style scoped></style>
