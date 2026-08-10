<template>
  <div>
			<div class="flag flex">
				<div class="bg-red-600 h-1 w-full"></div>
				<div class="bg-yellow-400 h-1 w-full"></div>
				<div class="bg-green-600 h-1 w-full"></div>
			</div>
			<div class="container flex">
				<header class="basis-1/2">
					<h1 class="text-2xl">Tunkun<span>ia</span></h1>
					<h2>{ inst.Name }</h2>
					<p>Tunkxx: { inst.Description }</p>
					<a href="/login">Ingresar con Ciudadanía Digital</a>
				</header>
				<main>
					<h2>Trámites Disponibles</h2>
					<ul>
						for _, item := range inst.Tramites {
							<li>
								<article>
									<h3>{ item.Name }</h3>
									<p>{ item.Description }</p>
									<a href="#">Ver + Detalles</a>
								</article>
							</li>
						}
					</ul>
				</main>
			</div>
  </div>
</template>