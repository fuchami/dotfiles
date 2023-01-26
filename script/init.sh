#!/bin/zsh

# Macの初期セットアップをする

if [ "$(uname)" != "Darwin" ] ; then
	echo "Not macOS!"
	exit 1
fi

# Install xcode
echo "install xcode..."
xcode-select --install > /dev/null

# Install brew
echo "install brew..."
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" > /dev/null

# Install brew/cask application
echo "install application with Brewfile..."
brew bundle --global