#!/bin/zsh

# 設定ファイルのシンボリックリンクを作成する

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

for dotfile in "${SCRIPT_DIR}"/.??* ; do
    [[ "$dotfile" == "${SCRIPT_DIR}/.git" ]] && continue
    [[ "$dotfile" == "${SCRIPT_DIR}/.github" ]] && continue
    [[ "$dotfile" == "${SCRIPT_DIR}/.DS_Store" ]] && continue

    # zsh系の設定ファイルに関しての処理
    if [[ "$(basename "$dotfile")" == .z* ]] && [[ -d "$HOME/.zprezto/runcoms/" ]]; then
        ln -fnsv "$dotfile" "$HOME/.zprezto/runcoms"
    else
        ln -fnsv "$dotfile" "$HOME"
    fi

done
