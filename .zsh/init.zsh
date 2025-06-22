command -v starship > /dev/null && eval "$(starship init zsh)"
command -v zoxide > /dev/null && eval "$(zoxide init --cmd cd zsh)"
command -v mise > /dev/null && eval "$($HOME/.local/bin/mise activate zsh)"
