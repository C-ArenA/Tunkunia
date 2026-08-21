<script setup lang="ts">
const { state, saveInstitution } = useTunkuniaDemo();
const form = reactive(structuredClone(state.value.institution));
const saved = ref(false);
function save() {
  saveInstitution({ ...form });
  saved.value = true;
  setTimeout(() => (saved.value = false), 2500);
}
</script>
<template>
  <UDashboardPanel
    ><template #header
      ><UDashboardNavbar title="Institución"
        ><template #right
          ><UButton
            label="Guardar cambios"
            icon="i-lucide-save"
            @click="save" /></template></UDashboardNavbar></template
    ><template #body
      ><UAlert
        v-if="saved"
        color="success"
        title="Información institucional actualizada"
        icon="i-lucide-circle-check" />
      <div>
        <p class="eyebrow">Identidad pública</p>
        <h1 class="page-title mt-2">Datos de la institución</h1>
        <p class="mt-3 text-slate-600">
          Esta información se muestra en el portal público y en las aplicaciones internas.
        </p>
      </div>
      <div class="mt-8 grid gap-6 xl:grid-cols-[1fr_320px]">
        <div class="surface grid gap-5 p-6 md:grid-cols-2">
          <UFormField label="Nombre" class="md:col-span-2"
            ><UInput v-model="form.name" class="w-full" /></UFormField
          ><UFormField label="Sigla"><UInput v-model="form.acronym" class="w-full" /></UFormField
          ><UFormField label="URL del logotipo"
            ><UInput v-model="form.logoUrl" class="w-full" /></UFormField
          ><UFormField label="Descripción" class="md:col-span-2"
            ><UTextarea v-model="form.description" class="w-full" /></UFormField
          ><UFormField label="Correo"
            ><UInput v-model="form.email" type="email" class="w-full" /></UFormField
          ><UFormField label="Teléfono"><UInput v-model="form.phone" class="w-full" /></UFormField
          ><UFormField label="Dirección" class="md:col-span-2"
            ><UInput v-model="form.address" class="w-full" /></UFormField
          ><UFormField label="Sitio web" class="md:col-span-2"
            ><UInput v-model="form.website" class="w-full" /></UFormField
          ><UFormField label="Color principal"
            ><UInput v-model="form.primaryColor" type="color" class="w-full" /></UFormField
          ><UFormField label="Color de acento"
            ><UInput v-model="form.accentColor" type="color" class="w-full"
          /></UFormField>
        </div>
        <aside class="surface h-fit p-6">
          <p class="text-sm font-semibold">Vista previa</p>
          <div
            class="mt-4 rounded-2xl p-5 text-white"
            :style="{ backgroundColor: form.primaryColor }"
          >
            <span class="grid size-12 place-items-center rounded-xl bg-white/15 font-bold">{{
              form.acronym
            }}</span>
            <h2 class="mt-5 text-xl font-semibold">{{ form.name }}</h2>
            <p class="mt-2 text-sm text-white/75">{{ form.description }}</p>
            <div class="mt-5 h-1 w-20 rounded" :style="{ backgroundColor: form.accentColor }" />
          </div>
        </aside></div></template
  ></UDashboardPanel>
</template>
