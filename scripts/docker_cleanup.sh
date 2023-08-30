#!/bin/bash

# Run this script regularly (e.g. monthly) depending on disk usage in /var/lib/docker
# Document downtime and pick a low-traffic time
# Example cron job:
# 0 0 1 * * ./docker_cleanup.sh

# Stop runners and remove cached Docker images, volumes, and networks
./remove.sh
sudo docker system prune -a -f --volumes

# Then reinstall
./install.sh
