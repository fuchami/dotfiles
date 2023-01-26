#!/bin/zsh

# 設定ファイルのシンボリックリンクを作成する

DOTFILES_HOME=~/dotfiles

for dotfile in "${DOTFILES_HOME}"/.??* ; do
    [[ "$dotfile" == "${DOTFILES_HOME}/.git" ]] && continue
    [[ "$dotfile" == "${DOTFILES_HOME}/.github" ]] && continue
    [[ "$dotfile" == "${DOTFILES_HOME}/.DS_Store" ]] && continue

    echo "found ${dotfile}"
    # ln -fnsv "$dotfile" "$HOME"
done