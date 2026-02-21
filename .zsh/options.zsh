HISTFILE=~/.histfile
HISTSIZE=1000000
SAVEHIST=1000000

setopt autocd
setopt HIST_IGNORE_SPACE
setopt HIST_IGNORE_DUPS
setopt HIST_FIND_NO_DUPS
setopt SHARE_HISTORY

# Filter out common/sensitive commands from history
# Add commands to skip or keywords to filter below
_hist_ignore_cmds=(ls exit cd cat cdi vi nvim k9s claude codex)
_hist_ignore_keywords=(AWS SECRET secret)
_hist_ignore_prefixes=(export)

zshaddhistory() {
  local line="${1%%$'\n'}"
  local cmd="${line%% *}"

  for c in $_hist_ignore_cmds; do
    [[ "$cmd" == "$c" ]] && return 1
  done

  for k in $_hist_ignore_keywords; do
    [[ "$line" == *"$k"* ]] && return 1
  done

  for p in $_hist_ignore_prefixes; do
    [[ "$cmd" == "$p" ]] && return 1
  done

  return 0
}

bindkey -e
