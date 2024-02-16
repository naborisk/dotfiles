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

# Sourcing path files
if [ -f ~/.path ]; then
  . ~/.path
fi

if command -v zoxide > /dev/null; then
  eval "$(zoxide init --cmd cd zsh)"
fi

eval "$(starship init zsh)"
export PATH=$PATH:$HOME/.naborisk/bin
source ~/.naborisk/aliases
