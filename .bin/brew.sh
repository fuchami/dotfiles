#!/bin/bash

# Brewfileを読み込んでコマンド・アプリをインストール

if [ "$(uname)" != "Darwin" ] ; then
	echo "Not macOS!"
	exit 1
fi

brew bundle --global
