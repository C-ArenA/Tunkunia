<script setup lang="ts">
import { getUserQuery } from "#shared/clientV1/@pinia/colada.gen";
import { updateUserAccess } from "#shared/clientV1/sdk.gen";
const route = useRoute();
const id = Number(route.params.id);
const saving = ref(false);
const saved = ref(false);
const actionError = ref("");
const { data: item, status, error: loadError, refresh } = useQuery(getUserQuery({ path: { id } }));
async function toggle(access: "isAdmin" | "isPublicServant") {
  if (!item.value) return;
  saving.value = true;
  saved.value = false;
  actionError.value = "";
  const response = await updateUserAccess({
    path: { id },
    body: {
      isAdmin: access === "isAdmin" ? !item.value.isAdmin : item.value.isAdmin,
      isPublicServant:
        access === "isPublicServant" ? !item.value.isPublicServant : item.value.isPublicServant,
    },
  });
  saving.value = false;
  if (response.error) {
    actionError.value = "No se pudo actualizar el acceso del usuario.";
    return;
  }
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
      <USkeleton v-if="status === 'pending'" class="h-48" />
      <UAlert v-else-if="loadError || !item" color="error" title="Usuario no encontrado" />
      <template v-else>
        <UAlert v-if="saved" class="mb-5" color="success" title="Acceso actualizado" />
        <UAlert v-if="actionError" class="mb-5" color="error" :title="actionError" />
        <div class="surface p-6">
          <h1 class="text-2xl font-semibold">{{ item.name }}</h1>
          <p class="mt-1 text-slate-500">{{ item.email }}</p>
          <UBadge class="mt-4" label="Ciudadano" color="neutral" variant="subtle" />
          <div class="mt-6 flex flex-wrap gap-3">
            <UButton
              :loading="saving"
              :label="
                item.isPublicServant ? 'Revocar servidor público' : 'Conceder servidor público'
              "
              :color="item.isPublicServant ? 'error' : 'primary'"
              variant="soft"
              @click="toggle('isPublicServant')"
            />
            <UButton
              :loading="saving"
              :label="item.isAdmin ? 'Revocar administración' : 'Conceder administración'"
              color="neutral"
              variant="soft"
              @click="toggle('isAdmin')"
            />
          </div>
        </div>
      </template>
    </template>
  </UDashboardPanel>
</template>
