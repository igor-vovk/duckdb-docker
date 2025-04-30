# This file is added for development purposes only.

docker build -t my-duckdb:latest . && docker run --rm -it --name test -p 80:4213 my-duckdb:latest