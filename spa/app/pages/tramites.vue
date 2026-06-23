<script setup lang="ts">
interface Tramite {
    id: number
    name: string
    description: string
}
interface CollectionResponse<T> {
    data: T[]
    next_page_url: string
    previous_page_url: string
}

const { data } = await useFetch<CollectionResponse<Tramite>>('/api/v1/catalog/tramites', {
    method: 'GET',
    baseURL: 'http://localhost:8080',
    headers: {
        'Content-Type': 'application/json'
    }
})
const title = 'Trámites Disponibles'
</script>

<template>
    <UPageSection id="tramites" :title="title" description="Explora los trámites disponibles en nuestra plataforma.">
        <UTable :data="data?.data" :columns="[
            {
                accessorKey: 'id',
                header: 'ID'
            },
            {
                accessorKey: 'name',
                header: 'Trámite'
            },
            {
                accessorKey: 'description',
                header: 'Descripción'
            }
        ]" />
    </UPageSection>
</template>