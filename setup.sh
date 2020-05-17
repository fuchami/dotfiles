#!/bin/bash

DOT_FILE=(.vimrc .zshrc)

for file in ${DOT_FILE}
do
  ln -s $HOME/dotfiles/$file $HOME/$file
done