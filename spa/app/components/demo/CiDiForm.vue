<script setup lang="ts">
import computerIcon from "~/assets/icons/computer.svg";
import type { User } from "#shared/clientV1";
defineProps<{
  users: User[];
}>();
</script>
<template>
  <div class="flex flex-col items-center">
    <div class="w-10 border border-demo-primary rounded-md p-[0.08rem]">
      <img :src="computerIcon" alt="Computer Icon" />
    </div>
    <h1 class="text-2xl font-bold mt-4">Inicia sesión</h1>
    <p class="text-center text-demo-primary font-semibold">
      TUNKUNIA - Sistema de Gestión de Trámites
    </p>
    <p class="w-full text-sm font-bold my-2">Ingresar como:</p>
    <a
      :href="`/callback?code=${user.id}`"
      v-for="user in users"
      :key="user.id"
      class="bg-demo-primary text-white px-3 py-2 mb-3 w-full rounded-md text-sm font-bold text-center"
    >
      {{ user.name }}
    </a>
    <a href="/" class="text-demo-primary font-bold text-sm m-4"> Volver </a>
  </div>
</template>

<style scoped></style>
