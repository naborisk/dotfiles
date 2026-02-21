# Plugins key bindings
bindkey '^G' autosuggest-accept

# History substring search (up/down arrows search matching history)
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# Load fast-syntax-highlighting overlay (Kali-inspired theme)
[[ -f ~/.config/fsh/overlay.ini ]] && fast-theme XDG:overlay >/dev/null 2>&1
