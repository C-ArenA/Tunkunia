import { useQueryCache } from "@pinia/colada";
import { getMeQuery } from "#shared/clientV1/@pinia/colada.gen";

export default defineNuxtRouteMiddleware(async () => {
  const queryCache = useQueryCache();
  try {
    const state = await queryCache.refresh(queryCache.ensure(getMeQuery()));
    if (state.status === "success" && state.data?.isAdmin) return;
  } catch {
    // Treat missing identity or access as unauthorized.
  }
  return navigateTo("/app");
});
