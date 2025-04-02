#!/bin/zsh

## Note this install script is only wor codespaces! Don't use elsewhere

./download.sh x86_64-unknown-linux-musl
./dotfiles install-oh-my-zsh
./dotfiles apply-config codespaces-work.yaml
source ~/.zshrc

pushd "/workspaces/${RepositoryName}"
GIT_REMOTE=$(git remote)
jj git init --colocate
# This branch tracking happens to work, but makes naming assumptions about refs.
jj bookmark track $(git branch --format="%(upstream:lstrip=-1)@${GIT_REMOTE}")
popd
