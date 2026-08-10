<script setup lang="ts">
const items = [
  {
	Name: "Trámite 1",
	Description: "Descripción del trámite 1"
  },
  {
	Name: "Trámite 2",
	Description: "Descripción del trámite 2"
  },
  {
	Name: "Trámite 3",
	Description: "Descripción del trámite 3"
  },
  {
	Name: "Trámite 1",
	Description: "Descripción del trámite 1"
  },
  {
	Name: "Trámite 2",
	Description: "Descripción del trámite 2"
  },
  {
	Name: "Trámite 3",
	Description: "Descripción del trámite 3"
  }
]

const inst = {
	Name: "Institución de Ejemplo",
	Description: "Esta es una institución de ejemplo para mostrar cómo se vería la página de inicio."
}
</script>

<style scoped>

</style>
<template>
  <div>
			<div class="flag flex sticky top-0">
				<div class="bg-red-600 h-2 w-full"></div>
				<div class="bg-yellow-400 h-2 w-full"></div>
				<div class="bg-green-600 h-2 w-full"></div>
			</div>
			<div class="flex flex-col md:flex-row h-screen overflow-hidden">
				<header class="bg-gray-100 p-4 md:flex-1 flex md:flex-col items-center justify-between md:justify-center">
					<div class="flex flex-col items-center text-center gap-2 mb-4">
					<h1 class="text-2xl md:text-4xl">Tunkun<span>ia</span></h1>
					<h2 class="text-lg font-semibold">{{ inst.Name }}</h2>
					<p class="text-gray-600 hidden md:block text-center">Tunkunia: {{ inst.Description }}</p>
					</div>
					<a href="/login" class="bg-green-500 text-white py-2 px-4 rounded hover:bg-green-600">Ingresar con Ciudadanía Digital</a>
				</header>
				<main class="bg-white p-4 flex-1 overflow-y-auto">
					<h2 class="text-2xl font-bold">Trámites Disponibles</h2>
					<p class="text-gray-600 md:hidden">Tunkunia: {{ inst.Description }}</p>
					<ul class="flex flex-col gap-4">
							<li v-for="item in items">
								<article class="border p-4 rounded hover:shadow-lg transition-shadow duration-300">
									<h3 class="text-xl font-semibold">{{ item.Name }}</h3>
									<p class="text-gray-600">{{ item.Description }}</p>
									<a href="#" class="text-blue-500 hover:text-blue-700">Ver + Detalles</a>
								</article>
							</li>
					</ul>
				</main>
			</div>
  </div>
</template>