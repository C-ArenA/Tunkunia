# DEMO ONLY: embeds bin/.env and uses ephemeral SQLite storage.
FROM debian:bookworm-slim

RUN apt-get update \
    && apt-get install --no-install-recommends --yes ca-certificates \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY bin/tunkunia ./tunkunia
COPY bin/.env ./.env

RUN chmod 0555 ./tunkunia

ENV PORT=8080
EXPOSE 8080

ENTRYPOINT ["sh", "-c", "case \"${PORT:-}\" in *:*) ;; *) PORT=\"0.0.0.0:${PORT:-8080}\"; export PORT ;; esac; exec /app/tunkunia serve"]
