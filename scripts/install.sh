#!/bin/bash

# Helper script to deploy/redeploy self-hosted runners

sudo systemctl stop gh-actions-runner
sudo install -m 644 gh-actions-runner-compose.yml /etc/
sudo install -m 600 gh-actions-runner.env /etc/
sudo install -m 644 gh-actions-runner.service /etc/systemd/system
sudo systemctl daemon-reload
sudo systemctl enable gh-actions-runner
sudo systemctl start gh-actions-runner
