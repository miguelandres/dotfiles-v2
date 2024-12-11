#!/bin/zsh

## Note this install script is only wor codespaces! Don't use elsewhere

./download.sh x86_64-unknown-linux-musl
./dotfiles install-oh-my-zsh
./dotfiles apply-config codespaces-work.yaml
resource
