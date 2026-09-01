<script setup lang="ts">
import {
  getDraftProcedure,
  getPublishedProcedure,
  getTramite,
  publishProcedure,
  saveDraftProcedure,
  updateTramite,
} from "#shared/clientV1/sdk.gen";
import type { TramiteStatus, TramiteType } from "#shared/clientV1/types.gen";
import type { ProcedureDefinition } from "#shared/clientV1/types.gen";
const route = useRoute();
const id = Number(route.params.id);
const saving = ref(false);
const publishing = ref(false);
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
const graph = ref<ProcedureDefinition>(newProcedure());
const procedureResponse = await getDraftProcedure({ path: { id } });
if (procedureResponse.data) graph.value = structuredClone(procedureResponse.data.definition);
else {
  const publishedResponse = await getPublishedProcedure({ path: { id } });
  if (publishedResponse.data) graph.value = structuredClone(publishedResponse.data.definition);
}
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
  const { status: _status, ...metadata } = form;
  const response = await updateTramite({ path: { id }, body: metadata });
  const procedureResponse = await saveDraftProcedure({ path: { id }, body: graph.value });
  saving.value = false;
  if (response.error || procedureResponse.error) {
    error.value = "No se pudieron guardar los cambios.";
    return;
  }
  saved.value = true;
  setTimeout(() => (saved.value = false), 2200);
}
async function publish() {
  await save();
  if (error.value) return;
  publishing.value = true;
  const response = await publishProcedure({ path: { id } });
  publishing.value = false;
  if (response.error) {
    const payload = response.error as { violations?: { message: string }[] };
    error.value =
      payload.violations?.map((item) => item.message).join(" ") || "La red no pudo publicarse.";
    return;
  }
  form.status = "published";
  saved.value = true;
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
          ><UButton label="Guardar cambios" icon="i-lucide-save" :loading="saving" @click="save" />
          <UButton
            label="Publicar versión"
            icon="i-lucide-upload"
            :loading="publishing"
            @click="publish" /></template></UDashboardNavbar></template
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
          <UBadge
            :label="
              form.status === 'published'
                ? 'Publicado'
                : form.status === 'archived'
                  ? 'Archivado'
                  : 'Borrador'
            "
          />
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
                class="mb-5 rounded-xl border border-emerald-200 bg-emerald-50 p-4 text-sm text-emerald-900"
              >
                El borrador se guarda en el servidor. Publicarlo crea una versión inmutable y
                verifica la WF-net.
              </div>
              <ProcedureEditor v-model="graph" /></div></template></UTabs></template></template
  ></UDashboardPanel>
</template>
