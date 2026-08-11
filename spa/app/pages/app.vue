<template>
    <div>
        <h1>Welcome to Tunkunia {{ me?.name }}</h1>
    </div>
</template>

<script setup lang="ts">

import { getMeQuery } from '#shared/clientV1/@pinia/colada.gen'
    const { data: me } = useQuery(getMeQuery)
</script>

<style scoped>

</style>