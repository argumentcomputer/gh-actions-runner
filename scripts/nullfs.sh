#!/bin/bash

## Script to install and configure nullfs to force-deactivate public param caching

# Install nullfs
git clone https://github.com/abbbi/nullfsvfs.git
cd nullfsvfs
sudo apt-get install debhelper dkms
sudo dpkg-buildpackage -r
# Update below version as needed
sudo dpkg -i ../nullfsvfs_0.17_amd64.deb

# Set up nullfs
sudo modprobe nullfs
echo nullfs | sudo tee /etc/modules-load.d/nullfs.conf
NFS_USERNAME=$(whoami)
NFS_UID=$(id -u $NFS_USERNAME)
NFS_GID=$(id -g $NFS_USERNAME)
sudo mkdir -p /var/tmp/runner/lurk
echo "none /var/tmp/runner/lurk nullfs default,uid=$NFS_UID,gid=$NFS_GID 0 0" | sudo tee -a /etc/fstab

# Mount nullfs to the Docker runner
echo "      - '/var/tmp/runner/lurk:/root/.lurk'" >> gh-actions-runner-compose.yml

# Mount nullfs to the file system
sudo mount -a
# Check it worked
mount

