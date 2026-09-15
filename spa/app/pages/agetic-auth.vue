<script setup lang="ts">
import { listUsersQuery } from "#shared/clientV1/@pinia/colada.gen";

const { data: users } = useQuery(listUsersQuery);
function onUserClick(userId: number) {
  console.log("User clicked:", userId);
  //post to route /demo-callback with userId
  fetch("/demo-callback", {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
    },
    body: JSON.stringify({ user_id: userId }),
  }).then((response) => {
    if (response.ok) {
      console.log("Demo callback successful");
      // redirect to /app
      window.location.href = "/app";
    } else {
      console.error("Demo callback failed");
    }
  });
}
</script>

<template>
  <div>Ciudadanía Digital</div>
  <p>{{ users }}</p>
  <button
    v-for="user in users"
    :key="user.id"
    class="bg-blue-500 text-white px-4 py-2 rounded"
    @click="onUserClick(user.id)"
  >
    {{ user.id }} - {{ user.name }}
  </button>
</template>

<style scoped></style>
