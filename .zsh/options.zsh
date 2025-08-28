HISTFILE=~/.histfile
HISTSIZE=1000000
SAVEHIST=1000000

setopt autocd
setopt HIST_IGNORE_SPACE
setopt HIST_IGNORE_DUPS
setopt HIST_FIND_NO_DUPS

export HISTORY_IGNORE="(ls|exit|cd|cat|cdi|vi|nvim|k9s|*AWS*|*SECRET*|*secret*|export *)"

bindkey -e
