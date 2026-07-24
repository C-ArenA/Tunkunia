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
    // About proxies in Nuxt: https://youtu.be/J4E5uYz5AY8?si=RbFLdZ2HrJJowPiB
    routeRules: {
      '/api/**': { proxy: 'http://localhost:8080/api/**' },
      // Solving redirect on proxies issue: https://github.com/nuxt/nuxt/discussions/27701#discussioncomment-9818736
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
