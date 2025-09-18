# set dotconfig
export HISTFILE="$XDG_STATE_HOME"/zsh/history
autoload -Uz compinit && compinit

# switch machine type for nvim config
export NVIM_PROFILE="private"

HISTSIZE=50000
SAVEHIST=50000
setopt append_history
setopt share_history
setopt hist_ignore_all_dups

bindkey -e
source <(fzf --zsh)

# # pyenv
export PYENV_ROOT="$XDG_DATA_HOME"/pyenv
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"

# For google-cloud-sdk
source "$(brew --prefix)/share/google-cloud-sdk/path.zsh.inc"
source "$(brew --prefix)/share/google-cloud-sdk/completion.zsh.inc"

# terraform
autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /opt/homebrew/bin/terraform terraform

# aliase
alias vim="nvim"
alias v="nvim"
alias c="clear"

# eza-ls alias
# https://gist.github.com/AppleBoiy/04a249b6f64fd0fe1744aff759a0563b
alias ls='eza --color=always --group-directories-first --icons'
alias ll='eza -la --icons --octal-permissions --group-directories-first'
alias l='eza -bGF --header --git --color=always --group-directories-first --icons'
alias la='eza --long --all --group --group-directories-first'
alias lS='eza -1 --color=always --group-directories-first --icons'
alias lt='eza --tree --level=2 --color=always --group-directories-first --icons'

eval "$(sheldon source)"

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

eval "$(starship init zsh)"
