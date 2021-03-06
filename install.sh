#!/usr/bin/env bash
set -eu

# paths
dirname=$(pwd)
lib="/usr/local/lib"
bin="/usr/local/bin"

# make in case they aren't already there
sudo mkdir -p $lib
sudo mkdir -p $bin

# Copy the path
sudo cp -R $dirname "$lib/"

# remove existing bin if it exists
if [ -e "$bin/dots" ]; then
  sudo rm "$bin/dots"
fi

# symlink dots
sudo ln -s "$lib/dots/dots.sh" "$bin/dots"

# Ubuntu-only: Change from dash to bash
if [ "$BASH_VERSION" = '' ]; then
  sudo echo "dash    dash/sh boolean false" | debconf-set-selections ; dpkg-reconfigure --frontend=noninteractive dash
fi
