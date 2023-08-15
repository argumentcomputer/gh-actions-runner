#!/bin/bash

# Run this script regularly depending on disk usage
./remove.sh
rm -r /var/tmp/runner/_work/*
sudo docker system prune -a --volumes

# Then reinstall with install.sh
