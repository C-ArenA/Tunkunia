<script setup lang="ts">
import { listUsers, updateUserRoles } from "#shared/clientV1/sdk.gen";
const route = useRoute();
const id = Number(route.params.id);
const saving = ref(false);
const saved = ref(false);
const { data: item, refresh } = await useAsyncData(`admin-user-${id}`, async () => {
  const response = await listUsers();
  return response.data?.find((user) => user.id === id);
});
async function toggle(role: "admin" | "servant") {
  if (!item.value) return;
  saving.value = true;
  const roles = item.value.roles.includes(role)
    ? item.value.roles.filter((current) => current !== role)
    : [...item.value.roles, role];
  await updateUserRoles({
    path: { id },
    body: {
      roles: roles.filter(
        (current): current is "admin" | "servant" => current === "admin" || current === "servant",
      ),
    },
  });
  saving.value = false;
  saved.value = true;
  await refresh();
}
</script>
<template>
  <UDashboardPanel>
    <template #header
      ><UDashboardNavbar title="Detalle de usuario"
        ><template #left
          ><UButton
            to="/admin/usuarios"
            icon="i-lucide-arrow-left"
            color="neutral"
            variant="ghost" /></template></UDashboardNavbar
    ></template>
    <template #body>
      <UAlert v-if="!item" color="error" title="Usuario no encontrado" />
      <template v-else>
        <UAlert v-if="saved" class="mb-5" color="success" title="Roles actualizados" />
        <div class="surface p-6">
          <h1 class="text-2xl font-semibold">{{ item.name }}</h1>
          <p class="mt-1 text-slate-500">{{ item.email }}</p>
          <div class="mt-6 flex flex-wrap gap-3">
            <UButton
              :loading="saving"
              :label="item.roles.includes('servant') ? 'Revocar servidor' : 'Conceder servidor'"
              :color="item.roles.includes('servant') ? 'error' : 'primary'"
              variant="soft"
              @click="toggle('servant')"
            />
            <UButton
              :loading="saving"
              :label="
                item.roles.includes('admin') ? 'Revocar administración' : 'Conceder administración'
              "
              color="neutral"
              variant="soft"
              @click="toggle('admin')"
            />
          </div>
        </div>
      </template>
    </template>
  </UDashboardPanel>
</template>
