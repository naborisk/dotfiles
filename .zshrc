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

# Load zinit
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

if command -v starship > /dev/null; then
  eval "$(starship init zsh)"
fi

if command -v zoxide > /dev/null; then
  eval "$(zoxide init --cmd cd zsh)"
fi

export PATH=$PATH:$HOME/.naborisk/bin
source ~/.naborisk/aliases

# Sourcing local zshrc (for paths, etc.)
[ -e ~/.zshrc.local ] && . ~/.zshrc.local

# Disable telemetry
[ -e ~/.telemetry.zsh ] && . ~/.telemetry.zsh

# Sourcing completions
if command -v argo > /dev/null; then
  source <(argo completion zsh)
fi

[ -e /usr/share/fzf/key-bindings.zsh ] && source /usr/share/fzf/key-bindings.zsh
[ -e /usr/share/fzf/completion.zsh ] && source /usr/share/fzf/completion.zsh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

source <(starship completions zsh)

st() {
  export STARSHIP_STATUS="$@ "
}
