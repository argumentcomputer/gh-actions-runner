#!/bin/bash

# E.g. ../test-runner/gh-actions-runner*
scp /path/to/runner/gh-actions-runner* <user>@<ip_addr>:/path/to/home

# For GPU setup, replace setup.sh with gpu_setup.sh below
scp setup.sh install.sh remove.sh runner_cleanup.sh docker_cleanup.sh <user>@<ip_addr>:/path/to/home
