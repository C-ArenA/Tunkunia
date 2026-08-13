import { useQueryCache } from "@pinia/colada";
//import { getMeQuery } from "#shared/clientV1/@pinia/colada.gen";

export default defineNuxtRouteMiddleware(async () => {
  const queryCache = useQueryCache();
  //const meQuery = queryCache.ensure(getMeQuery());
  //const meQuery = queryCache.ensure();

  try {
    // Refresh the me query to ensure it's up-to-date
    //const state = await queryCache.refresh(meQuery);
    const state = {
      status: "error",
      data: null,
    };

    if (state.status === "success" && state.data) {
      return;
    }
  } catch {
    // A missing or expired session is treated as unauthenticated.
  }

  return navigateTo("/");
});
