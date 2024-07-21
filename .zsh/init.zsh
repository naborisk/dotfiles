if command -v starship > /dev/null; then
  eval "$(starship init zsh)"
fi

if command -v zoxide > /dev/null; then
  eval "$(zoxide init --cmd cd zsh)"
fi
