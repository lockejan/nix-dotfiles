#!/usr/bin/env bash

# Make sure needed directories and symlinks are present
mkdir -p $HOME/.config
ln -s $(pwd)/home-manager/ $HOME/.config/nixpkgs
ln -s $(pwd)/darwin/ $HOME/.nixpkgs
