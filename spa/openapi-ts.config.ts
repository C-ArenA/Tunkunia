import { defineConfig } from "@hey-api/openapi-ts";

export default defineConfig({
  input: "../specs/v1.openapi.yaml", // sign up at app.heyapi.dev
  output: "./shared/clientV1",
  plugins: [
    {
      name: "@hey-api/client-ofetch",
      runtimeConfigPath: "./shared/heyApiV1",
    },
    "@pinia/colada",
  ],
});
