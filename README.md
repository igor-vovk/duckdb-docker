# duckdb-docker

Spawns DuckDB with enabled UI in the container

## Motivation

DuckDB is so handy tool when executed locally on your laptop or embedded.
In the same time, in some scenarios you would prefer to run it somewhere in the cloud –
for example, your scenarios involve a lot of reading and writing to S3, and your laptop's internet connection is not
that good, or you want to have better understanding what are the timings of your queries near the data.

After DuckDB added a built-in UI, it is now possible to run it in a container and access the UI from your
laptop.
