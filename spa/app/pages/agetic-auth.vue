<script setup lang="ts">
import { listUsersQuery } from "#shared/clientV1/@pinia/colada.gen";
import logo from "~/assets/images/CDV3-H.svg";
import boliviaLogo from "~/assets/images/logo_estado_plurinacional_bolivia.svg";
const { data: users } = useQuery(listUsersQuery);
</script>

<template>
  <div
    class="min-h-screen font-poppins bg-demo-background flex flex-col items-center p-5 demo-lg:px-10"
  >
    <header class="w-full flex justify-end gap-2">
      <button class="text-demo-primary">
        <UIcon class="size-6" name="i-ic-round-help-outline" />
      </button>
      <button class="text-demo-primary">
        <UIcon class="size-6" name="i-ic-outline-light-mode" />
      </button>
    </header>
    <div class="w-36 demo-lg:mt-12">
      <img :src="logo" alt="Logo" />
    </div>
    <main
      class="min-w-56 w-full max-w-96 demo-lg:max-w-4xl bg-demo-card p-6 flex flex-col demo-lg:flex-row demo-lg:items-center demo-lg:justify-evenly"
    >
      <DemoCiDiForm :users="users ?? []" />
      <DemoCiDiQR />
    </main>
    <footer class="flex flex-col items-center mt-auto gap-3">
      <div class="w-32 p-3">
        <img :src="boliviaLogo" alt="Logo del Estado Plurinacional de Bolivia" />
      </div>
      <p class="text-center opacity-60">AGETIC 2026</p>
    </footer>
  </div>
</template>

<style scoped></style>
