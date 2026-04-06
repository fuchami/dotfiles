# yazi wrapper
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

# ghq + fzf wrapper
function ghq-fzf() {
  local src=$(ghq list | fzf --preview "bat --color=always --style=header,grid --line-range :80 $(ghq root)/{}/README.*")
  if [ -n "$src" ]; then
    BUFFER="cd $(ghq root)/$src"
    zle accept-line
  fi
  zle -R -c
}
zle -N ghq-fzf
bindkey '^g' ghq-fzf

# zoxide wrapper
function zn() {
  z "$@" && nvim
}

function zin() {
  zi "$@" && nvim
}

# nb query - Search notes and select with fzf preview
# Usage: nbq <search query>
function nbq() {
  if [ -z "$1" ]; then
    echo "Usage: nbq <search query>"
    return 1
  fi

  local query="$*"
  local results=$(nb q "$query" --no-color 2>/dev/null | grep -E '^\[[0-9]+\]')

  if [ -z "$results" ]; then
    echo "No results found for: $query"
    return 1
  fi

  export _NBQ_QUERY="$query"

  local selected=$(echo "$results" | fzf --ansi \
    --preview 'note_id=$(echo {} | sed -E "s/^\[([0-9]+)\].*/\1/")
               echo "=== Note [$note_id] ==="
               echo ""
               nb show "$note_id" | head -5
               echo ""
               echo "=== Matching lines ==="
               echo ""
               nb show "$note_id" | grep -i --color=always -C 2 "$_NBQ_QUERY" | head -30' \
    --preview-window=right:60%:wrap \
    --header "Search: $query")

  unset _NBQ_QUERY

  if [ -n "$selected" ]; then
    local note_id=$(echo "$selected" | sed -E 's/^\[([0-9]+)\].*/\1/')
    nb edit "$note_id"
  fi
}
