if command -v starship > /dev/null; then
  eval "$(starship init zsh)"
fi

if command -v zoxide > /dev/null; then
  eval "$(zoxide init --cmd cd zsh)"
fi

typeset -a sources

sources=(
  $HOME/.zsh/options.zsh
  $HOME/.zsh/completions.zsh
  $HOME/.zsh/telemetry.zsh
  $HOME/.zsh/aliases.zsh
  $HOME/.zsh/zinit.zsh
  $HOME/.zsh/aliases.zsh
  $HOME/.zsh/path.zsh

  $HOME/.fzf.zsh

  /usr/share/fzf/key-bindings.zsh
  /usr/share/fzf/completion.zsh
)

for source in $sources; do
  [ -e $source ] && source $source
done

# Sourcing local zshrc (for paths, etc.)
[ -e ~/.zshrc.local ] && . ~/.zshrc.local
