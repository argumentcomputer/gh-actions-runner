#!/bin/bash

# Run this script from its local `scripts` directory

# Edit this path for non-GPU runner
scp ../gpu-runner/gh-actions-runner* <user>@<ip_addr>:/path/to/home

# For non-GPU runner, replace gpu_setup.sh with setup.sh below
scp gpu_setup.sh nullfs.sh install.sh remove.sh runner_cleanup.sh docker_cleanup.sh <user>@<ip_addr>:/path/to/home
