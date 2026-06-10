package catalog

type Tramite struct {
	ID   int    `json:"id"`
	Name string `json:"name"`
}

type TramiteUpdatePayload struct {
	Name *string
}
