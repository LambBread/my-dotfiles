#!/bin/sh

mkdir -p ~/.config/conky
mkdir -p ~/.config/bspwm

ln -sfrn ~/.dotfiles/alacritty ~/.config/alacritty
ln -sfrn ~/.dotfiles/cortile ~/.config/cortile
ln -sfrn ~/.dotfiles/fastfetch ~/.config/fastfetch
ln -sfrn ~/.dotfiles/ghostty ~/.config/ghostty
ln -sfrn ~/.dotfiles/gtk-3.0 ~/.config/gtk-3.0
ln -sfrn ~/.dotfiles/nvim ~/.config/nvim
ln -sfrn ~/.dotfiles/picom ~/.config/picom
ln -sfrn ~/.dotfiles/redshift ~/.config/redshift
ln -sfrn ~/.dotfiles/sxhkd ~/.config/sxhkd
ln -sfrn ~/.dotfiles/xsettingsd ~/.config/xsettingsd
ln -sfrn ~/.dotfiles/home/.bash_aliases ~/.bash_aliases
ln -sfrn ~/.dotfiles/home/.tmux.conf ~/.tmux.conf
if [ "$1" = laptop ]; then
    ln -sfrn ~/.dotfiles/conky/conky_laptop.conf ~/.config/conky/conky.conf
    ln -sfrn ~/.dotfiles/bspwm/bspwmrc_laptop ~/.config/bspwm/bspwmrc
    ln -sfrn ~/.dotfiles/home/laptop.bashrc ~/.bashrc
    ln -sfrn ~/.dotfiles/home/laptop.Xmodmap ~/.Xmodmap
else
    ln -sfrn ~/.dotfiles/conky/conky.conf ~/.config/conky/conky.conf
    ln -sfrn ~/.dotfiles/bspwm/bspwmrc ~/.config/bspwm/bspwmrc
    ln -sfrn ~/.dotfiles/home/.bashrc ~/.bashrc
    ln -sfrn ~/.dotfiles/home/.Xmodmap ~/.Xmodmap
fi
