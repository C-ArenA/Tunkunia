<script setup lang="ts">
import { createTramite } from "#shared/clientV1/sdk.gen";
import type { TramiteType } from "#shared/clientV1/types.gen";
const form = reactive({
  name: "",
  description: "",
  procedureDescription: "",
  type: "Otro" as TramiteType,
});
const saving = ref(false);
const error = ref("");
const types: TramiteType[] = [
  "Otro",
  "Trámite de registro",
  "Trámite de certificación",
  "Trámite de constancia",
  "Trámite para cumplir con obligaciones",
  "Trámite para acceder a servicios",
  "Trámite para obtener permisos",
];
async function save() {
  error.value = "";
  if (!form.name.trim()) {
    error.value = "El nombre es obligatorio.";
    return;
  }
  saving.value = true;
  const response = await createTramite({ body: { ...form } });
  saving.value = false;
  if (response.error || !response.data) {
    error.value = "No se pudo crear el trámite.";
    return;
  }
  await navigateTo(`/admin/tramites/${response.data.id}`);
}
</script>
<template>
  <UDashboardPanel
    ><template #header
      ><UDashboardNavbar title="Nuevo trámite"
        ><template #left
          ><UButton
            to="/admin/tramites"
            icon="i-lucide-arrow-left"
            color="neutral"
            variant="ghost" /></template
        ><template #right
          ><UButton
            label="Crear borrador"
            icon="i-lucide-save"
            :loading="saving"
            @click="save" /></template></UDashboardNavbar></template
    ><template #body
      ><div>
        <p class="eyebrow">Nuevo servicio</p>
        <h1 class="page-title mt-2">Crear trámite</h1>
        <p class="mt-3 text-slate-600">
          El trámite se guardará como borrador y podrá publicarse después.
        </p>
      </div>
      <UAlert v-if="error" class="mt-6" color="error" :title="error" />
      <div class="surface mt-8 grid max-w-4xl gap-5 p-6">
        <UFormField label="Nombre" required
          ><UInput v-model="form.name" class="w-full" /></UFormField
        ><UFormField label="Tipo"
          ><USelect v-model="form.type" :items="types" class="w-full" /></UFormField
        ><UFormField label="Descripción"
          ><UTextarea v-model="form.description" class="w-full" :rows="4" /></UFormField
        ><UFormField label="Descripción del procedimiento"
          ><UTextarea v-model="form.procedureDescription" class="w-full" :rows="5"
        /></UFormField></div></template
  ></UDashboardPanel>
</template>
