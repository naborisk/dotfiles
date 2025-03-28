#!/bin/bash

FILES_TO_UNLINK=".tmux.conf .prettierrc .telemetry.zsh .zsh .zshrc .config/starship.toml .naborisk .config/nvim/ Library/LaunchAgents/com.user.loginscript.plist"

for FILE in $FILES_TO_UNLINK
do
  # check if the file is a link to this repo then unlink it
  if [[ -L "$HOME/$FILE" ]]; then
    echo "unlinking $FILE"
    unlink $HOME/$FILE
  fi
done

FILES_TO_DELETE="Library/LaunchAgents/com.user.loginscript.plist .local/share/nvim .local/share/zinit"

for FILE in $FILES_TO_DELETE
do
  # check if the file is a link to this repo then unlink it
  if [[ -f "$HOME/$FILE" || -d "$HOME/$FILE" ]]; then
    echo "deleting $FILE"
    rm -rf $HOME/$FILE
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
exec $SHELL
