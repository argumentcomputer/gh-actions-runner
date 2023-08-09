#!/bin/bash

# E.g. ../test-runner/gh-actions-runner*
scp /path/to/runner/gh-actions-runner* root@<ip_addr>:/root


# For GPU setup, replace setup.sh with gpu_setup.sh below
scp setup.sh install.sh remove.sh root@<ip_addr>:/root 
