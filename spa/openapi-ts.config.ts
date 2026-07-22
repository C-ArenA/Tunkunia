import { defineConfig } from '@hey-api/openapi-ts'

export default defineConfig({
  input: './../tunkunia.openapi.yaml', // sign up at app.heyapi.dev
  output: './shared/client',
  plugins: [
    {
      name: '@hey-api/client-ofetch',
      runtimeConfigPath: './shared/hey-api'
    },
    '@pinia/colada'
  ]
})
