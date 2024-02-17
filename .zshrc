# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt autocd
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/naborisk/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

setopt HIST_IGNORE_SPACE

autoload -U +X bashcompinit && bashcompinit

if command -v starship > /dev/null; then
  eval "$(starship init zsh)"
fi

if command -v zoxide > /dev/null; then
  eval "$(zoxide init --cmd cd zsh)"
fi

export PATH=$PATH:$HOME/.naborisk/bin
source ~/.naborisk/aliases

# Sourcing local zshrc (for paths, etc.)
if [ -f ~/.zshrc.local ]; then
  . ~/.zshrc.local
fi
