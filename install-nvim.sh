#!/bin/bash


# install plugins
nvim --headless +PackerClean +PackerInstall +PackerCompile +qa
