# TODO: move this to better place
export ASDF_DATA_DIR="$HOME/.asdf"

export PATH=$PATH:$HOME/.zsh/bin
export PATH=$ASDF_DATA_DIR/shims:$PATH

[ -d /opt/nvim ] && export PATH=/opt/nvim:$PATH
