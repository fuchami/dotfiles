export HISTFILE="$XDG_STATE_HOME"/zsh/history
HISTSIZE=50000
SAVEHIST=50000

setopt append_history
setopt share_history
setopt hist_ignore_all_dups
setopt hist_reduce_blanks

bindkey -e

# yazi wrapper
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

[[ -f "$HOME/.local/bin/env" ]] && source "$HOME/.local/bin/env"

autoload -Uz compinit && compinit
eval "$(sheldon source)"
eval "$(oh-my-posh init zsh --config $XDG_CONFIG_HOME/oh-my-posh/mytheme.omp.yaml)"
