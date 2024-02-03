FROM archlinux
RUN pacman-key --init
RUN pacman -Sy archlinux-keyring --noconfirm
RUN pacman -Syu --noconfirm
# current neovim setup requires which
RUN pacman -S --noconfirm zsh git neovim which
RUN chsh -s /usr/bin/zsh

WORKDIR /root
COPY . ./dotfiles

RUN cd ./dotfiles && ./setup.sh
ENTRYPOINT ["/usr/bin/zsh"]
