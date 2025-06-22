command -v starship > /dev/null && eval "$(starship init zsh)"
command -v zoxide > /dev/null && eval "$(zoxide init --cmd cd zsh)"
test -e $HOME/.local/bin/mise > /dev/null && eval "$($HOME/.local/bin/mise activate zsh)"
