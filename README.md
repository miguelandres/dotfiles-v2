# Miguely's Dotfiles v2

[![Test install profiles](https://github.com/miguelandres/dotfiles_v2/actions/workflows/install-profile-test.yml/badge.svg)](https://github.com/miguelandres/dotfiles_v2/actions/workflows/install-profile-test.yml)

This is a migration of my old
[dotfiles](http://github.com/miguelandres/dotfiles) to using
[miguelandres/dotfiles-rs](http://github.com/miguelandres/dotfiles-rs) as the
backing for maintainability and testability.

## Getting started

```sh
[ -f ~/.ssh/id_rsa ] || ssh-keygen -t rsa -b 4096 -C "miguelandres@users.noreply.github.com"
eval "$(ssh-agent -s)"
if [ `uname` = "Darwin" ]; then;
  tee ~/.ssh/config << EOF
Host *
  AddKeysToAgent yes
  UseKeychain yes
  IdentityFile ~/.ssh/id_rsa
EOF
fi
ssh-add -K ~/.ssh/id_rsa 2>/dev/null || ssh-add ~/.ssh/id_rsa

echo "Put the following key in your github account."
cat ~/.ssh/id_rsa.pub

mkdir ~/src
cd ~/src
git clone --recurse-submodules -j8 git@github.com:miguelandres/dotfiles_v2.git
cd ~/src/dotfiles_v2/

# Hackily download dotfiles from github directly.
./download.sh

# Use the hacky download to install homebrew and OhMyZsh!
./dotfiles install-homebrew
./dotfiles install-oh-my-zsh
# Remove hacky download
rm dotfiles

# Use homebrew to properly install it and get updates when available
brew tap miguelandres/homebrew-tap
brew install dotfiles-rs
```

## Profiles and configs

### Personal mac

```sh
dotfiles apply-config mac-personal-migue.yaml
```

### Mati's mac

```sh
dotfiles apply-config mac-personal-mati.yaml
```

### Work Mac

```sh
dotfiles apply-config mac-work.yaml
```
