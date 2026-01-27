### locale
export LANG="ja_JP.UTF-8"

### XDG
export XDG_CONFIG_HOME=$HOME/.config/
export XDG_DATA_HOME=$HOME/.local/share/
export XDG_STATE_HOME=$HOME/.local/state/
export XDG_CACHE_HOME=$HOME/.cache/

### zsh (same config is written in /etc/zshenv for macOS)
export ZDOTDIR="$HOME"/.config/zsh

### zshrc specific
export HISTFILE="$XDG_STATE_HOME"/zsh/history
HISTSIZE=50000
SAVEHIST=50000
