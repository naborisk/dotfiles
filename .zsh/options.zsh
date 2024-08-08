HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=10000

setopt autocd
setopt HIST_IGNORE_SPACE
setopt HIST_IGNORE_DUPS
setopt HIST_FIND_NO_DUPS

export HISTORY_IGNORE="(ls|cat|vi|nvim|k9s|*AWS*|*SECRET*|*secret*|export *)"

bindkey -e
