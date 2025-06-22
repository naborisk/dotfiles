command -v starship > /dev/null && eval "$(starship init zsh)"
command -v zoxide > /dev/null && eval "$(zoxide init --cmd cd zsh)"
# for local installation of mise
test -e $HOME/.local/bin/mise > /dev/null && eval "$($HOME/.local/bin/mise activate zsh)"
# for brew installation of mise
command -v mise > /dev/null && eval "$(mise activate zsh)"
