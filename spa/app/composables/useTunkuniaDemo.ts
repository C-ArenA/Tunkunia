import type { InstitutionSettings } from "~/types/tunkunia";

const STORAGE_KEY = "tunkunia.institution.v2";
const defaults = (): InstitutionSettings => ({
  name: "Gobierno Autónomo Municipal de Tunkunia",
  acronym: "GAMT",
  description: "Servicios públicos digitales, claros y accesibles para toda la ciudadanía.",
  logoUrl: "",
  email: "contacto@tunkunia.gob.bo",
  phone: "+591 2 244 0000",
  address: "Plaza Principal, La Paz, Bolivia",
  website: "https://tunkunia.gob.bo",
  primaryColor: "#087443",
  accentColor: "#d3a000",
});

export function useTunkuniaDemo() {
  const state = useState("tunkunia-institution", () => ({ institution: defaults() }));
  const hydrated = useState("tunkunia-institution-hydrated", () => false);
  const persist = () => {
    if (import.meta.client)
      localStorage.setItem(STORAGE_KEY, JSON.stringify(state.value.institution));
  };
  if (import.meta.client && !hydrated.value) {
    const stored = localStorage.getItem(STORAGE_KEY);
    if (stored) {
      try {
        state.value.institution = { ...defaults(), ...JSON.parse(stored) };
      } catch {
        localStorage.removeItem(STORAGE_KEY);
      }
    }
    hydrated.value = true;
  }
  const reset = () => {
    state.value.institution = defaults();
    persist();
  };
  const saveInstitution = (institution: InstitutionSettings) => {
    state.value.institution = { ...institution };
    persist();
  };
  return { state, reset, saveInstitution };
}
