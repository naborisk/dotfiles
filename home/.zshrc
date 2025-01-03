typeset -a sources

sources=(
  $HOME/.zsh/init.zsh

  $HOME/.zsh/options.zsh
  $HOME/.zsh/telemetry.zsh
  $HOME/.zsh/aliases.zsh
  $HOME/.zsh/zinit.zsh
  $HOME/.zsh/path.zsh
  $HOME/.zsh/completions.zsh

  $HOME/.fzf.zsh

  /usr/share/fzf/key-bindings.zsh
  /usr/share/fzf/completion.zsh

  $HOME/.zshrc.local
)

for source in $sources; do
  [ -e $source ] && source $source
done
