<script setup lang="ts">
import { getTramite, updateTramite } from "#shared/clientV1/sdk.gen";
import type { TramiteStatus, TramiteType } from "#shared/clientV1/types.gen";
import type { ProcedureGraph } from "~/types/tunkunia";
const route = useRoute();
const id = Number(route.params.id);
const { getGraph, saveGraph } = useTunkuniaDemo();
const saving = ref(false);
const saved = ref(false);
const error = ref("");
const { data: tramite, status } = await useAsyncData(`admin-tramite-${id}`, async () => {
  const response = await getTramite({ path: { id } });
  if (response.error) throw response.error;
  return response.data;
});
const form = reactive({
  name: "",
  description: "",
  procedureDescription: "",
  type: "Otro" as TramiteType,
  status: "draft" as TramiteStatus,
});
const graph = ref<ProcedureGraph>(structuredClone(getGraph(id)));
watch(
  tramite,
  (value) => {
    if (value)
      Object.assign(form, {
        name: value.name,
        description: value.description,
        procedureDescription: value.procedureDescription,
        type: value.type,
        status: value.status,
      });
  },
  { immediate: true },
);
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
  saving.value = true;
  const response = await updateTramite({ path: { id }, body: { ...form } });
  saving.value = false;
  if (response.error) {
    error.value = "No se pudieron guardar los cambios.";
    return;
  }
  saveGraph(id, graph.value);
  saved.value = true;
  setTimeout(() => (saved.value = false), 2200);
}
</script>
<template>
  <UDashboardPanel
    ><template #header
      ><UDashboardNavbar title="Editar trámite"
        ><template #left
          ><UButton
            to="/admin/tramites"
            icon="i-lucide-arrow-left"
            color="neutral"
            variant="ghost" /></template
        ><template #right
          ><UButton
            label="Guardar cambios"
            icon="i-lucide-save"
            :loading="saving"
            @click="save" /></template></UDashboardNavbar></template
    ><template #body
      ><USkeleton v-if="status === 'pending'" class="h-96" /><UAlert
        v-else-if="!tramite"
        color="error"
        title="Trámite no encontrado" /><template v-else
        ><UAlert
          v-if="saved"
          color="success"
          title="Cambios guardados"
          icon="i-lucide-circle-check" /><UAlert
          v-if="error"
          class="mt-4"
          color="error"
          :title="error" />
        <div class="flex flex-col justify-between gap-5 lg:flex-row lg:items-end">
          <div>
            <p class="eyebrow">Configuración</p>
            <h1 class="page-title mt-2">{{ form.name }}</h1>
          </div>
          <UFormField label="Estado de publicación"
            ><USelect
              v-model="form.status"
              :items="[
                { label: 'Borrador', value: 'draft' },
                { label: 'Publicado', value: 'published' },
                { label: 'Archivado', value: 'archived' },
              ]"
              class="w-48"
          /></UFormField>
        </div>
        <UTabs
          class="mt-8"
          :items="[
            { label: 'Información', slot: 'information' },
            { label: 'Procedimiento', slot: 'procedure' },
          ]"
          variant="link"
          ><template #information
            ><div class="surface mt-4 grid gap-5 p-6">
              <UFormField label="Nombre"><UInput v-model="form.name" class="w-full" /></UFormField
              ><UFormField label="Tipo"
                ><USelect v-model="form.type" :items="types" class="w-full" /></UFormField
              ><UFormField label="Descripción"
                ><UTextarea v-model="form.description" class="w-full" /></UFormField
              ><UFormField label="Descripción del procedimiento"
                ><UTextarea v-model="form.procedureDescription" class="w-full"
              /></UFormField></div></template
          ><template #procedure
            ><div class="mt-4">
              <div
                class="mb-5 rounded-xl border border-amber-200 bg-amber-50 p-4 text-sm text-amber-900"
              >
                El diagrama se guarda como dato local de demostración hasta que exista su endpoint.
              </div>
              <ProcedureEditor v-model="graph" /></div></template></UTabs></template></template
  ></UDashboardPanel>
</template>
