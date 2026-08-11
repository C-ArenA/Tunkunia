<script setup lang="ts">
import type { NavigationMenuItem } from "@nuxt/ui";
import { getMeQuery } from "#shared/clientV1/@pinia/colada.gen";
const { data: me } = useQuery(getMeQuery);
const items: NavigationMenuItem[][] = [
  [
    {
      label: "Trámites",
      icon: "i-lucide-house",
      to: "/app",
    },
    {
      label: "Bandeja",
      icon: "i-lucide-inbox",
      badge: "4",
      to: "/app/bandeja",
    },
    {
      label: "Configuración",
      icon: "i-lucide-settings",
      defaultOpen: true,
      children: [
        {
          label: "General",
        },
        {
          label: "Members",
        },
        {
          label: "Notifications",
        },
      ],
    },
  ],
  [
    {
      label: "Feedback",
      icon: "i-lucide-message-circle",
      to: "https://github.com/nuxt-ui-templates/dashboard",
      target: "_blank",
    },
    {
      label: "Help & Support",
      icon: "i-lucide-info",
      to: "https://github.com/nuxt/ui",
      target: "_blank",
    },
  ],
];
</script>
<template>
  <UDashboardGroup>
    <UDashboardSidebar collapsible resizable :ui="{ footer: 'border-t border-default' }">
      <template #header="{ collapsed }">
        <div v-if="!collapsed" class="h-5 w-auto shrink-0">Tunkunia</div>
        <UIcon v-else name="i-simple-icons-nuxtdotjs" class="size-5 text-primary mx-auto" />
      </template>
      <template #default="{ collapsed }">
        <UNavigationMenu :collapsed="collapsed" :items="items[0]" orientation="vertical" />
      </template>
      <template #footer="{ collapsed }">
        <UButton
          :avatar="{
            src: 'https://github.com/benjamincanac.png',
            loading: 'lazy' as const,
          }"
          :label="collapsed ? undefined : me?.name"
          color="neutral"
          variant="ghost"
          class="w-full"
          :block="collapsed"
        />
      </template>
    </UDashboardSidebar>

    <slot />
  </UDashboardGroup>
</template>
