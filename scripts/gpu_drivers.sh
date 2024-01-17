#!/bin/bash

# Disable popups to restart services after `apt-get upgrade` by restarting them automatically
sudo sed -i "s/\#\$nrconf{restart} = 'i';/\$nrconf{restart} = 'a';/" /etc/needrestart/needrestart.conf
# Don't install suggested or recommended packages with `apt`
printf "APT::Install-Suggests "0";\nAPT::Install-Recommends "0";" >> /etc/apt/apt.conf.d/99Recommended

sudo apt-get update && sudo apt-get upgrade -y
# Pin kernel version to prevent driver/kernel mismatches
sudo apt-mark hold linux-generic linux-image-generic linux-headers-generic

sudo apt-get install ubuntu-drivers-common -y
sudo ubuntu-drivers devices
# Edit with the desired driver number based on `ubuntu-drivers devices`
sudo ubuntu-drivers install 535
# Pin driver version to prevent driver/kernel mismatches
sudo apt-mark hold nvidia-driver-535

# Then reboot and run `nvidia-smi`
