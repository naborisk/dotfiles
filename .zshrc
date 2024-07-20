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

typeset -a sources

sources=(
  $HOME/.zsh/telemetry.zsh
  $HOME/.zsh/aliases.zsh
  $HOME/.zsh/zinit.zsh
  $HOME/.zsh/aliases.zsh

  $HOME/.fzf.zsh

  /usr/share/fzf/key-bindings.zsh
  /usr/share/fzf/completion.zsh
)

for source in $sources; do
  [ -e $source ] && source $source
done

if command -v starship > /dev/null; then
  eval "$(starship init zsh)"
fi

if command -v zoxide > /dev/null; then
  eval "$(zoxide init --cmd cd zsh)"
fi

export PATH=$PATH:$HOME/.naborisk/bin
# source ~/.naborisk/aliases

# Sourcing local zshrc (for paths, etc.)
[ -e ~/.zshrc.local ] && . ~/.zshrc.local

# Sourcing completions
if command -v argo > /dev/null; then
  source <(argo completion zsh)
fi

# [ -e /usr/share/fzf/key-bindings.zsh ] && source /usr/share/fzf/key-bindings.zsh
# [ -e /usr/share/fzf/completion.zsh ] && source /usr/share/fzf/completion.zsh

# [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

source <(starship completions zsh)

st() {
  if [ "$#" -eq 0 ]; then
    unset STARSHIP_STATUS
  else
    export STARSHIP_STATUS="$@ "
  fi
}
