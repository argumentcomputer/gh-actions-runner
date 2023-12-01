#!/bin/bash

sudo apt-get update && sudo apt-get upgrade -y
sudo apt-get install ubuntu-drivers-common -y
sudo ubuntu-drivers devices
sudo ubuntu-drivers autoinstall

# Then reboot and run `nvidia-smi`
