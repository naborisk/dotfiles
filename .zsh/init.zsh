# macOS: initialize homebrew (ensures brew is in PATH for all shell types)
if [[ "$OSTYPE" == "darwin"* ]]; then
  if [[ -f /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  elif [[ -f /usr/local/bin/brew ]]; then
    eval "$(/usr/local/bin/brew shellenv)"
  fi
fi

command -v starship > /dev/null && eval "$(starship init zsh)"
command -v zoxide > /dev/null && eval "$(zoxide init --cmd cd zsh)"

# mise activation is deferred to after first prompt via zinit in zinit.zsh
