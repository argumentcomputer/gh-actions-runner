#!/bin/bash

# For peace of mind that the workdir exists
mkdir -p /var/tmp/runner/_work
# Generate a unique, persistent id for each runner directory
head /dev/urandom | tr -dc a-f0-9 | head -c 13 > /var/tmp/runner/_work/runner_id.txt
_RUNNER_ID="$(cat /var/tmp/runner/_work/runner_id.txt)"
RUNNER_NAME="${RUNNER_NAME}-${_RUNNER_ID}"
RUNNER_WORKDIR="${RUNNER_WORKDIR}/${_RUNNER_ID}"

exec /entrypoint.sh $@
