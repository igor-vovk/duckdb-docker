#!/bin/sh

ARCH=$(uname -m)

if [ "$ARCH" = "x86_64" ]; then
  exec /app/amd64/duckdb --listen --interface=0.0.0.0 "$@"
elif [ "$ARCH" = "aarch64" ] || [ "$ARCH" = "arm64" ]; then
  exec /app/aarch64/duckdb --listen --interface=0.0.0.0 "$@"
else
  echo "Unsupported architecture: $ARCH"
  exit 1
fi