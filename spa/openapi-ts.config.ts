import { defineConfig } from '@hey-api/openapi-ts';

export default defineConfig({
  input: './../api/joined.openapi.yaml', // sign up at app.heyapi.dev
  output: './shared/client'
});