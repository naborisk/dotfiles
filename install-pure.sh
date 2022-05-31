#!/usr/bin/env zsh

if grep -q "prompt pure"  $HOME/.zshrc; then
    echo 'pure already installed, exiting...'
    exit 1
fi

mkdir -p "$HOME/.zsh"
git clone https://github.com/sindresorhus/pure.git "$HOME/.zsh/pure"

echo '\n# Add pure prompt to PATH' >> $HOME/.zshrc
echo 'fpath+=$HOME/.zsh/pure\n' >> $HOME/.zshrc

echo '# load pure prompt' >> $HOME/.zshrc
echo 'autoload -U promptinit; promptinit' >> $HOME/.zshrc
echo 'prompt pure' >> $HOME/.zshrc

echo "installation done! please run 'source ~/.zshrc' or restart the shell to use pure prompt"
