#!/bin/bash

# Disable popups to restart services after `apt-get upgrade` by restarting them automatically
sudo sed -i "s/\#\$nrconf{restart} = 'i';/\$nrconf{restart} = 'a';/" /etc/needrestart/needrestart.conf
# Don't install suggested or recommended packages with `apt`
printf "APT::Install-Suggests "0";\nAPT::Install-Recommends "0";" >> /etc/apt/apt.conf.d/99Recommended

sudo apt-get update && sudo apt-get upgrade -y
# Pin kernel version to prevent driver/kernel mismatches
sudo apt-mark hold linux-generic

# `alsa-utils` is needed to fix an `aplay` error when running `ubuntu-drivers devices`
sudo apt-get install ubuntu-drivers-common alsa-utils -y
# Edit with the desired driver version based on `ubuntu-drivers devices`
NVIDIA_DRIVER_VERSION=$(sudo ubuntu-drivers devices | grep "recommended" | awk -F'-' '{ print $3 }')

sudo ubuntu-drivers install $NVIDIA_DRIVER_VERSION
# Pin driver version to prevent driver/kernel mismatches
sudo apt-mark hold nvidia-driver-$NVIDIA_DRIVER_VERSION

# Then reboot and run `nvidia-smi`
