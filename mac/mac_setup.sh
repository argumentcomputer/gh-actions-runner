#!/bin/bash

softwareupdate --install-rosetta

# Install homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
(echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> /Users/administrator/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"

brew install wget
brew install docker

# TODO: check this is downloading correctly
# Install Docker Desktop
wget -O /Users/administrator/Docker.dmg https://desktop.docker.com/mac/main/arm64/Docker.dmg?utm_source=docker&utm_medium=webreferral&utm_campaign=docs-driven-download-mac-arm64

sudo hdiutil attach Docker.dmg

sudo /Volumes/Docker/Docker.app/Contents/MacOS/install

sudo hdiutil detach /Volumes/Docker

sudo docker run hello-world

