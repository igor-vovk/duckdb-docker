FROM debian:bullseye-slim AS base

FROM base AS builder

ARG DUCKDB_VERSION=1.2.1

WORKDIR /app

RUN apt-get update && \
    apt-get install -y --no-install-recommends wget unzip ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Download both amd64 and aarch64 versions
RUN wget https://github.com/duckdb/duckdb/releases/download/v${DUCKDB_VERSION}/duckdb_cli-linux-amd64.zip -O duckdb_cli-amd64.zip && \
    wget https://github.com/duckdb/duckdb/releases/download/v${DUCKDB_VERSION}/duckdb_cli-linux-aarch64.zip -O duckdb_cli-aarch64.zip && \
    mkdir -p /app/amd64 /app/aarch64 && \
    unzip duckdb_cli-amd64.zip -d /app/amd64 && \
    unzip duckdb_cli-aarch64.zip -d /app/aarch64 && \
    rm duckdb_cli-amd64.zip duckdb_cli-aarch64.zip && \
    chmod +x /app/amd64/duckdb && \
    chmod +x /app/aarch64/duckdb

FROM base AS runtime

WORKDIR /app

RUN groupadd --gid 1001 duckdb && \
    useradd --uid 1001 --gid 1001 --shell /bin/bash --create-home duckdb

COPY --from=builder /app/amd64/duckdb /app/amd64/duckdb
COPY --from=builder /app/aarch64/duckdb /app/aarch64/duckdb

COPY duckdb-wrapper.sh /app/duckdb-wrapper.sh
RUN chmod +x /app/duckdb-wrapper.sh && \
    chown -R duckdb:duckdb /app

USER duckdb

EXPOSE 4213

ENTRYPOINT ["/app/duckdb-wrapper.sh"]

CMD ["-ui"]