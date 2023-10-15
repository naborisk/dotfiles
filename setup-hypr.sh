#!/bin/bash

rm -rf ~/.config/waybar
rm -rf ~/.config/hypr
rm -rf ~/.config/wofi

ln -sfn $(readlink -f config/waybar) ~/.config/waybar
ln -sfn $(readlink -f config/hypr) ~/.config/hypr
ln -sfn $(readlink -f config/wofi) ~/.config/wofi
