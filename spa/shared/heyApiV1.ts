// Needs the generated files
import type { CreateClientConfig } from './clientV1/client.gen'
import { navigateTo } from 'nuxt/app'

export const createClientConfig: CreateClientConfig = config => ({
  ...config,
  baseUrl: '/api/v1',
  onResponse: ({response}) => {
    if (response.status == 401) {
      navigateTo('/')
    }
  }
})