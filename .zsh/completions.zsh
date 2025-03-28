zstyle :compinstall filename "$HOME/.zsh/compinit.zsh"

autoload -Uz compinit
compinit

autoload -U +X bashcompinit
bashcompinit

# Sourcing completions
if command -v argo > /dev/null; then
  source <(argo completion zsh)
fi

if command -v starship > /dev/null; then
  source <(starship completions zsh)
fi

if command -v gh > /dev/null; then
  source <(gh completion -s zsh)
fi

if command -v asdf > /dev/null; then
  source <(asdf completion zsh)
fi

if command -v docker > /dev/null; then
  source <(docker completion zsh)
fi
