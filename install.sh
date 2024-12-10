#!/bin/zsh

./download.sh x86_64-unknown-linux-gnu
./dotfiles install-homebrew
./dotfiles install-oh-my-zsh
./dotfiles apply-config codespaces-work
