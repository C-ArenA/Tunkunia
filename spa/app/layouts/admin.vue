<script setup lang="ts">
import type { NavigationMenuItem } from "@nuxt/ui";
const { state, reset } = useTunkuniaDemo();
const items: NavigationMenuItem[] = [
  { label: "Resumen", icon: "i-lucide-gauge", to: "/admin" },
  { label: "Trámites", icon: "i-lucide-workflow", to: "/admin/tramites" },
  { label: "Usuarios", icon: "i-lucide-users", to: "/admin/usuarios" },
  { label: "Institución", icon: "i-lucide-landmark", to: "/admin/institucion" },
];
</script>

<template>
  <UDashboardGroup class="bg-slate-50">
    <UDashboardSidebar collapsible :ui="{ footer: 'border-t border-default' }">
      <template #header="{ collapsed }"
        ><span class="font-bold text-slate-900">{{
          collapsed ? state.institution.acronym : "Tunkunia · Admin"
        }}</span></template
      >
      <UNavigationMenu :items="items" orientation="vertical" />
      <template #footer="{ collapsed }">
        <div class="space-y-2">
          <UButton
            to="/app"
            icon="i-lucide-arrow-left-right"
            :label="collapsed ? undefined : 'Volver a la aplicación'"
            color="neutral"
            variant="soft"
            class="w-full"
          />
          <UButton
            icon="i-lucide-refresh-cw"
            :label="collapsed ? undefined : 'Restablecer institución'"
            color="neutral"
            variant="ghost"
            class="w-full"
            @click="reset"
          />
          <UButton
            to="/oidc-logout"
            external
            icon="i-lucide-log-out"
            aria-label="Cerrar sesión"
            :label="collapsed ? undefined : 'Cerrar sesión'"
            color="neutral"
            variant="ghost"
            class="w-full"
          />
        </div>
      </template>
    </UDashboardSidebar>
    <slot />
  </UDashboardGroup>
</template>
