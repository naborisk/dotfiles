zstyle :compinstall filename "$HOME/.zsh/compinit.zsh"

autoload -Uz compinit
compinit

autoload -U +X bashcompinit
bashcompinit

# Sourcing completions
command -v argo > /dev/null && source <(argo completion zsh)
command -v starship > /dev/null && source <(starship completions zsh)
command -v gh > /dev/null && source <(gh completion -s zsh)
command -v docker > /dev/null && source <(docker completion zsh)
