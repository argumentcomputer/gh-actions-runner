#!/bin/bash

sudo sed -i "s/\#PasswordAuthentication.*/PasswordAuthentication no/" /etc/ssh/sshd_config
sudo systemctl reload sshd

sudo sed -i "s/\#MaxRetentionSec.*/MaxRetentionSec=3d/" /etc/systemd/journald.conf
sudo systemctl restart systemd-journald

# Hide kernel "pending upgrade" popup messages
sed -i "s/#\$nrconf{kernelhints} = -1;/\$nrconf{kernelhints} = -1;/g" /etc/needrestart/needrestart.conf
sed -i "s/#\$nrconf{restart} = 'i';/\$nrconf{restart} = 'a';/g" /etc/needrestart/needrestart.conf

# Don't install suggested or recommended packages
sudo printf \
"APT::Install-Suggests "0";\n\
APT::Install-Recommends "0";" > /etc/apt/apt.conf.d/99Recommended

# Lock kernel version to prevent issues with GPU drivers
sudo apt-mark hold linux-generic linux-image-generic linux-headers-generic

# Install Docker
sudo apt update -y
sudo apt-get install ca-certificates curl gnupg -y
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update -y
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y
# Verify installation
sudo docker run hello-world

# Ensure GPU drivers are working
nvidia-smi

# Install Nvidia Container Toolkit
distribution=$(. /etc/os-release;echo $ID$VERSION_ID) \
    && curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey | sudo gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg \
    && curl -s -L https://nvidia.github.io/libnvidia-container/$distribution/libnvidia-container.list | \
          sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#g' | \
          sudo tee /etc/apt/sources.list.d/nvidia-container-toolkit.list
sudo apt update -y
sudo apt install -y nvidia-container-toolkit
# Verify installation
nvidia-ctk --version
# Configure runtime 
sudo nvidia-ctk runtime configure --runtime=docker --set-as-default
sudo systemctl restart docker
# Verify Docker has access to GPU drivers
sudo docker run --rm --runtime=nvidia --gpus all nvidia/cuda:12.0.1-devel-ubuntu22.04 nvidia-smi

sudo echo \
	# This will create /dev/char symlinks to all device nodes \
	ACTION=="add", DEVPATH=="/bus/pci/drivers/nvidia", RUN+="/usr/bin/nvidia-ctk system create-dev-char-symlinks --create-all" \
	> /lib/udev/rules.d/71-nvidia-dev-char.rules
sudo udevadm control --reload-rules && udevadm trigger
