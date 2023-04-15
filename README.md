# Dotfiles
Various customizations for my own use

## Installation
To install, clone this repository, then run `setup.sh` from the repo
```sh
git clone https://github.com/naborisk/dotfiles

cd dotfiles

./setup.sh
```

Files from this repo will be symlinked to config files location, so it is required to keep this repo saved locally for the dotfiles to work

## Minimal Installation
Minimal installation will not symlink the files and is intended to be installed on remote devices. Minimal installation can be installed without cloning the repository.

```sh 
bash -c "$(curl -fsSL https://raw.githubusercontent.com/naborisk/dotfiles/main/setup-min.sh)"
```

## Updating dotfiles
If there are changes, to the files, just do a `git pull` and new files will work automatically

## Credits
`nvim/after/plugin/tabby.lua` and `nvim/after/plugin/feline.lua` are slightly edited from [nightfox.nvim](https://github.com/EdenEast/nightfox.nvim)'s tabby and feline configuration.
