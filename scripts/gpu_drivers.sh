#!/bin/bash

sudo apt-get update && sudo apt-get upgrade -y
sudo apt-get install ubuntu-drivers-common -y
sudo ubuntu-drivers devices
# Edit with the desired driver number (e.g. 535)
sudo ubuntu-drivers install <driver>

# Then reboot and run `nvidia-smi`
