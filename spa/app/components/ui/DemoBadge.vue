<script setup lang="ts">
import { useQuery } from "@pinia/colada";
import { getInstitutionQuery } from "#shared/clientV1/@pinia/colada.gen";
const { data: institution, } = useQuery(getInstitutionQuery);
</script>

<template>
  <div
    v-if="institution?.demo"
    class="fixed bottom-0 right-4 z-50 rounded-t-md bg-slate-950 px-1 py-1 text-xs font-semibold text-white shadow-2xl opacity-60 pointer-events-none"
  >
    DEMO
  </div>
</template>

<style scoped></style>
