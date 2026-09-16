<script setup lang="ts">
import demoQR from "~/assets/images/demoqr.png";
const steps = [
  "Abre la aplicación de Ciudadanía Digital",
  "En la pantalla principal haz clic en Escanear QR",
  "Escanea esta imagen para iniciar sesión",
];
</script>

<template>
  <div class="flex flex-col items-center gap-3">
    <div class="w-48">
      <img :src="demoQR" alt="Demo QR Code" />
    </div>
    <h2 class="font-semibold">Inicia sesión con código QR</h2>
    <ul class="text-sm">
      <li v-for="(step, index) in steps" :key="index">
        <p>{{ index + 1 }}. {{ step }}</p>
      </li>
    </ul>
  </div>
</template>

<style scoped></style>
