#!/bin/bash

# Note: build Docker images in this directory (scripts) with `-f /path/to/Dockerfile`

# For peace of mind that the workdir exists
mkdir -p /var/tmp/runner/_work
# Generate a unique, persistent id for each runner directory
RUNNER_DATE=$(date +"%m-%d-%y")
head /dev/urandom | tr -dc a-f0-9 | head -c 13 | sed 's/$/-'$RUNNER_DATE'/' > /var/tmp/runner/_work/runner_id.txt
_RUNNER_ID="$(cat /var/tmp/runner/_work/runner_id.txt)"
RUNNER_NAME="${RUNNER_NAME}-${_RUNNER_ID}"
RUNNER_WORKDIR="${RUNNER_WORKDIR}/${_RUNNER_ID}"

# Get hardware info and append to labels
LABELS="$(nproc --all) vCPUs"
LABELS=${LABELS},"$(sudo dmidecode -t 19 | awk -F ': ' '/Range Size/{print $2}' | tail -n 1) RAM"
if [ $(command -v nvidia-smi) ]; then
        LABELS=${LABELS},$(nvidia-smi --query-gpu=gpu_name --format=csv | tail -n 1)
        LABELS=${LABELS},"$(nvidia-smi --query-gpu=memory.total --format=csv | tail -n 1 | awk '{print $1 / 1024}') GB GPU RAM"
fi
# Add label for unique ID
LABELS=${LABELS},${_RUNNER_ID}

echo "Runner labels: $LABELS"
echo "Runner workdir: $RUNNER_WORKDIR"

exec /entrypoint.sh $@
