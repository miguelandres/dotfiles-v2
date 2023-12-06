#!/bin/bash

if [ `uname` == "Darwin" ]; then
	echo "Running on macOS, assuming homebrew is installed"
	exit 0
fi

sudo apt-get install build-essential curl file git
sh -c "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh)"

echo 'export PATH="/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin/:$PATH"' >> $BASH_ENV
echo 'export MANPATH="/home/linuxbrew/.linuxbrew/share/man:$MANPATH"' >> $BASH_ENV
echo 'export INFOPATH="/home/linuxbrew/.linuxbrew/share/info:$INFOPATH"' >> $BASH_ENV
