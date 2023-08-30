#!/bin/bash

# Note: build Docker images in this directory (scripts) with `-f /path/to/Dockerfile`

# For peace of mind that the workdir exists
mkdir -p /var/tmp/runner/_work
# Generate a unique, persistent id for each runner directory
RUNNER_DATE=$(date +"%y-%m-%d")
head /dev/urandom | tr -dc a-f0-9 | head -c 13 | sed 's/$/-'$RUNNER_DATE'/' > /var/tmp/runner/_work/runner_id.txt
_RUNNER_ID="$(cat /var/tmp/runner/_work/runner_id.txt)"
RUNNER_NAME="${RUNNER_NAME}-${_RUNNER_ID}"
RUNNER_WORKDIR="${RUNNER_WORKDIR}/${_RUNNER_ID}"

echo "Runner workdir: $RUNNER_WORKDIR"
exec /entrypoint.sh $@
