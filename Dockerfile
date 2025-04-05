FROM debian:bullseye-slim AS base

FROM base AS builder

ARG DUCKDB_VERSION=1.2.1

WORKDIR /app

RUN apt-get update && \
    apt-get install -y --no-install-recommends wget unzip ca-certificates \
    && rm -rf /var/lib/apt/lists/*

RUN wget https://github.com/duckdb/duckdb/releases/download/v${DUCKDB_VERSION}/duckdb_cli-linux-amd64.zip -O duckdb_cli.zip && \
    unzip duckdb_cli.zip && \
    rm duckdb_cli.zip && \
    chmod +x duckdb

FROM base AS runtime

WORKDIR /app

RUN groupadd --gid 1001 duckdb && \
    useradd --uid 1001 --gid 1001 --shell /bin/bash --create-home duckdb

COPY --from=builder /app/duckdb /app/duckdb

RUN chown -R duckdb:duckdb /app

USER duckdb

ENTRYPOINT ["/app/duckdb"]

CMD ["-ui"]