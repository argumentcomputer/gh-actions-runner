#!/bin/bash

# Helper script to purge the self-hosted runner systemd service
# Run install.sh afterward to reinstall

sudo systemctl stop gh-actions-runner
sudo systemctl disable gh-actions-runner
sudo rm /etc/systemd/system/gh-actions-runner.service
sudo rm /etc/systemd/system/gh-actions-runner.service # and symlinks that might be related
sudo rm /etc/gh-actions-runner.env
sudo rm /etc/gh-actions-runner-compose.yml
sudo rm /usr/lib/systemd/system/gh-actions-runner.service
sudo rm /usr/lib/systemd/system/gh-actions-runner.service # and symlinks that might be related
sudo systemctl daemon-reload
sudo systemctl reset-failed
