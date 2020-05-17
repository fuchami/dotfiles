#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...
fpath=(/usr/local/share/zsh-completions $fpath)

autoload -Uz colors ; colors
export CLICOLOR=1
# ヒストリの設定
HISTFILE=~/.zsh_history
HISTSIZE=30000
SAVEHIST=30000
# 直前のコマンドの重複を削除
setopt hist_ignore_dups
# 同じコマンドをヒストリに残さない
setopt hist_ignore_all_dups
# 同時に起動したzshの間でヒストリを共有
setopt share_history
# 補完機能を有効にする
autoload -Uz compinit
# 補完候補を詰めて表示
setopt list_packed
# コマンドのスペルチェックをする
setopt correct
# コマンドライン全てのスペルチェックをする
setopt correct_all
# ビープ音を鳴らさないようにする
#setopt no_beep

# alias
