<script setup lang="ts">
import { listTramitesQuery, getMeQuery } from '#shared/clientV1/@pinia/colada.gen'

const inst = {
	Name: "Institución de Ejemplo",
	Description: "Esta es una institución de ejemplo para mostrar cómo se vería la página de inicio."
}

const { data: tramites } = useQuery(listTramitesQuery)
const { data: me } = useQuery(getMeQuery)
</script>

<style scoped>

</style>
<template>
  <div>
			<div class="flag flex sticky top-0">
				<div class="bg-red-600 h-1 w-full"></div>
				<div class="bg-yellow-400 h-1 w-full"></div>
				<div class="bg-green-600 h-1 w-full"></div>
			</div>
			<div class="flex flex-col md:flex-row h-screen overflow-hidden bg-white-50">
				<header class="p-4 md:flex-1 flex md:flex-col items-center justify-between md:justify-center">
					<div class="flex flex-col md:items-center md:text-center gap-2 mb-4">
					<h1 class="text-2xl md:text-4xl">Tunkun<span>ia</span></h1>
					<h2 class="text-lg font-semibold">{{ inst.Name }}</h2>
					<p class="text-gray-600 hidden md:block text-center px-4">Tunkunia: {{ inst.Description }}</p>
					</div>
					<a v-if="!me" href="/login" class="bg-green-500 text-white py-2 px-4 rounded hover:bg-green-600">Ingresar</a>
					<NuxtLink v-else to="/app" class="bg-green-500 text-white py-2 px-4 rounded hover:bg-green-600 mt-2 md:mt-4">Ingresar</NuxtLink>
				</header>
				<main class="p-4 flex-1 overflow-y-auto flex flex-col md:justify-center">
					<h2 class="text-2xl font-bold my-2 text-center md:hidden">Trámites Disponibles</h2>
					<p class="text-gray-600 md:hidden my-2">Tunkunia: {{ inst.Description }}</p>
					<ul class="flex flex-col gap-4">
							<li v-for="item in tramites?.data" :key="item.id">
								<article class="border border-primary p-4 rounded hover:shadow-lg transition-shadow duration-300">
									<h3 class="text-xl font-semibold">{{ item.name }}</h3>
									<p class="text-gray-600">{{ item.description }}</p>
									<a :href="`/tramites/${item.id}`" class="text-green-500 hover:text-green-700">Ver Detalles</a>
								</article>
							</li>
					</ul>
				</main>
			</div>
  </div>
</template>