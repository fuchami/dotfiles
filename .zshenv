### ZDOTDIR
export ZDOTDIR="$HOME/.config/zsh"

### locale
export LANG="ja_JP.UTF-8"

### XDG
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$HOME/.cache"

### PATH
typeset -gU cdpath fpath mailpath path
path=(
  $HOME/{,s}bin(N)
  $HOME/.local/bin(N)
  /opt/{homebrew,local}/{,s}bin(N)
  /usr/local/{,s}bin(N)
  $HOME/.opencode/bin(N)
  $path
)
