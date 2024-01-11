#!/bin/bash

# Run this script regularly (e.g. monthly) to update security and prevent driver issues
# Example cron job:
# 0 0 1 * * ./update-reboot.sh

sudo apt update && sudo apt upgrade
sudo reboot
