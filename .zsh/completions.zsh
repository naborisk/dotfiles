zstyle :compinstall filename "$HOME/.zsh/compinit.zsh"

command -v brew > /dev/null && [ -d $(brew --prefix)/share/zsh/site-functions ] && fpath+=($(brew --prefix)/share/zsh/site-functions)

autoload -Uz compinit
# Only regenerate completion dump once every 24 hours
if [[ -n ~/.zcompdump(#qN.mh+24) ]]; then
  compinit
else
  compinit -C
fi

autoload -U +X bashcompinit
bashcompinit

# Cache dynamic completions to files instead of running subprocesses every startup
_cache_dir="${XDG_CACHE_HOME:-$HOME/.cache}/zsh"
[ ! -d "$_cache_dir" ] && mkdir -p "$_cache_dir"

_cache_completion() {
  local cmd=$1 cache_file="$_cache_dir/_$1"
  shift
  if command -v "$cmd" > /dev/null; then
    if [[ ! -f "$cache_file" || ! -s "$cache_file" ]]; then
      "$@" > "$cache_file" 2>/dev/null
    fi
    source "$cache_file"
  fi
}

_cache_completion argo argo completion zsh
_cache_completion starship starship completions zsh
_cache_completion gh gh completion -s zsh
_cache_completion docker docker completion zsh

unset _cache_dir
unfunction _cache_completion
