#!/bin/sh

ARCH=$(uname -m)

if [ "$ARCH" = "x86_64" ]; then
  echo "Running on x86_64 architecture"
  exec /app/amd64/duckdb "$@"
elif [ "$ARCH" = "aarch64" ] || [ "$ARCH" = "arm64" ]; then
  echo "Running on aarch64 architecture"
  exec /app/aarch64/duckdb "$@"
else
  echo "Unsupported architecture: $ARCH"
  exit 1
fi