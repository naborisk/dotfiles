FILES_TO_REMOVE=".tmux.conf .prettierrc .telemetry.zsh .zsh/ .zshrc .config/starship.toml .naborisk .config/nvim/"

for FILE in $FILES_TO_REMOVE
do
  # check if the file is a link to this repo then unlink it
  if [[ -L "$HOME/$FILE" ]]; then
    echo "unlinking $FILE"
    unlink $HOME/$FILE
  fi
done


# check if --remove-starship flag is passed then execute as root
if [ "$EUID" -ne 0  ] && [ "$1" == "--remove-starship" ]; then
  echo '[starship] --remove-starship flag passed, removing starship'
  sudo bash -c 'rm "$(command -v 'starship')"'
else
  echo '[starship] --remove-starship flag not passed, skipping'
fi

# restart the shell
exec $SHELL -l
