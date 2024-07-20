FILES_TO_INSTALL=".tmux.conf .prettierrc .telemetry.zsh .zsh/ .zshrc .config/starship.toml .naborisk .config/nvim/"
for FILE in $FILES_TO_INSTALL
do
  # check if the file is a link to this repo then unlink it
  if [[ -L "$HOME/$FILE" ]]; then
    echo "unlinking $FILE"
    unlink $HOME/$FILE
  fi
done

echo 'removing starship'
sh -c 'rm "$(command -v 'starship')"'

# restart the shell
exec $SHELL -l
