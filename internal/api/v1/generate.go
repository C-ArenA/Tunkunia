package v1

//go:generate redocly bundle ./openapi.yaml --output ../../../v1.openapi.yaml
//go:generate redocly lint ../../../v1.openapi.yaml
//go:generate go tool oapi-codegen -config ./oapi/server.cfg.yaml -o ./oapi/oapi.gen.go ../../../v1.openapi.yaml
//go:generate go tool oapi-codegen -config ./oapi/models.cfg.yaml -o ./oapi/models.oapi.gen.go ../../../v1.openapi.yaml
