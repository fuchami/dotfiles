# set dotconfig
export HISTFILE="$XDG_STATE_HOME"/zsh/history
HISTSIZE=50000
SAVEHIST=50000
setopt append_history
setopt share_history
setopt hist_ignore_all_dups

bindkey -e
source <(fzf --zsh)

# For google-cloud-sdk
source "$(brew --prefix)/share/google-cloud-sdk/path.zsh.inc"
source "$(brew --prefix)/share/google-cloud-sdk/completion.zsh.inc"

# terraform
autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /opt/homebrew/bin/terraform terraform

# yazi wrapper
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

# Added by LM Studio CLI (lms)
export PATH="$PATH:/Users/fuchami/.lmstudio/bin"
# End of LM Studio CLI section

. "$HOME/.local/bin/env"

autoload -Uz compinit && compinit

eval "$(sheldon source)"
eval "$(starship init zsh)"
# eval "$(oh-my-posh init zsh --config ~/.config/omp/config.json)"
