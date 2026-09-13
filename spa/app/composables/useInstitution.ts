import { getInstitutionQuery } from "#shared/clientV1/@pinia/colada.gen";
import type { Institution } from "#shared/clientV1/types.gen";

export const defaultInstitution: Institution = {
  name: "Tunkunia",
  acronym: "T",
  description: "",
  logoUrl: "",
  email: "",
  phone: "",
  address: "",
  website: "",
  primaryColor: "#087443",
  accentColor: "#d3a000",
};

export function useInstitution() {
  const query = useQuery(getInstitutionQuery);
  const institution = computed(() => query.data.value ?? defaultInstitution);
  return { ...query, institution };
}
