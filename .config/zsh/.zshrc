export HISTFILE="$XDG_STATE_HOME"/zsh/history
HISTSIZE=50000
SAVEHIST=50000

setopt append_history
setopt share_history
setopt hist_ignore_all_dups
setopt hist_reduce_blanks

bindkey -e

[[ -f "$HOME/.local/bin/env" ]] && source "$HOME/.local/bin/env"

autoload -Uz compinit && compinit
eval "$(sheldon source)"
