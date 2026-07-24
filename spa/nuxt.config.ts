// https://nuxt.com/docs/api/configuration/nuxt-config
export default defineNuxtConfig({
  modules: ['@nuxt/eslint', '@nuxt/ui', '@pinia/nuxt', '@pinia/colada-nuxt'],
  ssr: false,

  devtools: {
    enabled: true
  },

  app: {
    head: {
      link: [{ rel: 'icon', href: '/favicon.ico' }],
      htmlAttrs: {
        lang: 'es'
      }
    }
  },

  css: ['~/assets/css/main.css'],

  compatibilityDate: '2025-01-15',

  nitro: {
    routeRules: {
      '/api/**': { proxy: 'http://localhost:8080/api/**' },
      '/login': { proxy: { to: 'http://localhost:8080/login', fetchOptions: { redirect: 'manual' } } },
      '/callback': { proxy: 'http://localhost:8080/callback' }
    }
  },

  hooks: {
    'prerender:routes'({ routes }) {
      routes.clear()
    }
  },

  eslint: {
    config: {
      stylistic: {
        commaDangle: 'never',
        braceStyle: '1tbs'
      }
    }
  }
})
