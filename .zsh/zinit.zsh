# Load zinit
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Plugins
zinit light Aloxaf/fzf-tab
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-history-substring-search

zinit light zdharma-continuum/fast-syntax-highlighting

# Defer mise activation (saves ~50-80ms startup time)
zinit ice wait'0' lucid if'test -e $HOME/.local/bin/mise || command -v mise > /dev/null'
zinit light-mode for \
atload'
    if test -e $HOME/.local/bin/mise; then
      eval "$($HOME/.local/bin/mise activate zsh)"
    elif command -v mise > /dev/null; then
      eval "$(mise activate zsh)"
    fi
  ' \
    naborisk/zinit-null
