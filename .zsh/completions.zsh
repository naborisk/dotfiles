zstyle :compinstall filename "$HOME/.zsh/compinit.zsh"

autoload -Uz compinit
compinit

autoload -U +X bashcompinit
bashcompinit

# Sourcing completions
if command -v argo > /dev/null; then
  source <(argo completion zsh)
fi

source <(starship completions zsh)
