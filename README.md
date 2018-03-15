# Stellar Horizon Docker image

## Docker Hub

The Docker images are automatically built and published at [starformlabs/stellar-horizon](https://hub.docker.com/r/starformlabs/stellar-horizon/).

## Credit

This repo was originally forked from [satoshipay/docker-stellar-horizon](https://github.com/satoshipay/docker-stellar-horizon). 
The following are the primary changes.

 - Use debian:stretch-slim for the base image
 - Install from binaries instead of source
 - Add a check to makes sure that postgres is up before starting
 
## Configuration

All environment variables that Stellar Horizon accepts are supported. You can find out all available options by running `docker run --rm -it satoshipay/stellar-horizon horizon --help`. CLI options are exposed as upper/snake-case environment variables, e.g., `--stellar-core-url` can be set with the `STELLAR_CORE_URL` environment variable.

Make sure to set the following variables:

* `DATABASE_URL`: *Horizon* database URL, e.g., `postgres://horizon-db-host/stellar-horizon`.
* `STELLAR_CORE_DATABASE_URL`: *Stellar Core* database URL, e.g., `postgres://core-db-host/stellar-core`.
* `STELLAR_CORE_URL`: *Stellar Core* HTTP URL, e.g., `http://core-host:11626`.
* `INGEST`: ingest data from Stellar Core (true/false)
