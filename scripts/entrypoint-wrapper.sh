#!/bin/bash

# Note: build Docker images in this directory (scripts) with `-f /path/to/Dockerfile`

# For peace of mind that the workdir exists
mkdir -p /var/tmp/runner/_work
# Generate a unique, persistent id for each runner directory
RUNNER_DATE=$(date +"%y-%m-%d")
head /dev/urandom | tr -dc a-f0-9 | head -c 13 | sed 's/$/-'$RUNNER_DATE'/' > /var/tmp/runner/_work/runner_id.txt
_RUNNER_ID="$(cat /var/tmp/runner/_work/runner_id.txt)"
# The name is a bit long, but there's no other way to give the runner a unique name with a scaled docker-compose runner
RUNNER_NAME="${RUNNER_NAME}-${_RUNNER_ID}"
RUNNER_WORKDIR="${RUNNER_WORKDIR}/${_RUNNER_ID}"

# Get hardware info and append to labels
LABELS=${LABELS},$(uname -ms)
LABELS=${LABELS},$(grep '^model name' /proc/cpuinfo | head -1 | awk -F ': ' '{ print $2 }')
LABELS=${LABELS},"$(nproc --all) vCPUs"
LABELS=${LABELS},$(grep MemTotal /proc/meminfo | awk '{$2=$2/(1024^2); printf "%.2f GB RAM\n", $2;}')
if [ $(command -v nvidia-smi) ]; then
        LABELS=${LABELS},"gpu",$(nvidia-smi --query-gpu=gpu_name --format=csv,noheader,nounits | tail -n 1)
        LABELS=${LABELS},$(nvidia-smi --query-gpu=memory.total --format=csv,noheader,nounits | tail -n 1 | awk '{$1=$1/1024; printf "%.2f GB GPU RAM\n", $1;}')
fi
# Add label for workdir/unique ID
LABELS=${LABELS},${_RUNNER_ID}

echo "Runner labels: $LABELS"
echo "Runner workdir: $RUNNER_WORKDIR"

exec /entrypoint.sh $@
