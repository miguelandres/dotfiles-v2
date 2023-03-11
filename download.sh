#!/bin/zsh

os=${1=macos-universal}

URL=$(curl -s https://api.github.com/repos/miguelandres/dotfiles-rs/releases/latest \
| grep "browser_download_url.*$os" \
| cut -d : -f 2,3 \
| tr -d \" \
| cut -c 2-)

echo "downloading $URL"
curl "$URL" -L -o df.tar.gz

tar -xzvf df.tar.gz dotfiles
rm df.tar.gz
