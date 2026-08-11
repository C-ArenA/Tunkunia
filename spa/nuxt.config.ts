import tailwindcss from "@tailwindcss/vite";
import { heyApiPlugin } from "@hey-api/vite-plugin";

// https://nuxt.com/docs/api/configuration/nuxt-config
export default defineNuxtConfig({
  compatibilityDate: "2025-07-15",
  devtools: { enabled: true },
  ssr: false,

  hooks: {
    "prerender:routes"({ routes }) {
      routes.clear(); // Do not generate any routes (except the defaults)
    },
  },

  css: ["~/assets/css/main.css"],

  vite: {
    plugins: [tailwindcss(), heyApiPlugin()],
  },

  modules: ["@pinia/colada-nuxt", "@pinia/nuxt", "@nuxt/ui"],
});
