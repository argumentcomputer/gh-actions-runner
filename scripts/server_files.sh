#!/bin/bash

# E.g. ../test-runner/gh-actions-runner*
scp /path/to/runner/gh-actions-runner* <user>@<ip_addr>:/root

# For GPU setup, replace setup.sh with gpu_setup.sh below
chmod +x server_setup.sh install.sh remove.sh
scp server_setup.sh install.sh remove.sh <user>@<ip_addr>:/root 
