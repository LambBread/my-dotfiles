#!/bin/sh

mkdir -p ~/Pictures
mkdir -p ~/Pictures/wallpaper
mkdir -p ~/.config/conky
mkdir -p ~/.config/bspwm
mkdir -p ~/.config/polybar
mkdir -p ~/.config/fastfetch
mkdir -p ~/.config/fastfetch/presets
curl https://www.socwall.com/images/wallpapers/34499-1920x1200.jpg -o ~/Pictures/wallpaper/wallpaper.jpg


ln -sfrn ~/.dotfiles/alacritty ~/.config/alacritty
ln -sfrn ~/.dotfiles/cortile ~/.config/cortile
ln -sfrn ~/.dotfiles/ghostty ~/.config/ghostty
ln -sfrn ~/.dotfiles/gtk-3.0 ~/.config/gtk-3.0
ln -sfrn ~/.dotfiles/nvim ~/.config/nvim
ln -sfrn ~/.dotfiles/picom ~/.config/picom
ln -sfrn ~/.dotfiles/redshift ~/.config/redshift
ln -sfrn ~/.dotfiles/sxhkd ~/.config/sxhkd
ln -sfrn ~/.dotfiles/xsettingsd ~/.config/xsettingsd
ln -sfrn ~/.dotfiles/dunst ~/.config/dunst
ln -sfrn ~/.dotfiles/polybar/scripts ~/.config/polybar/scripts
ln -sfrn ~/.dotfiles/fastfetch/logos ~/.config/fastfetch/logos
ln -sfrn ~/.dotfiles/fastfetch/presets/default.jsonc ~/.config/fastfetch/presets/default.jsonc
ln -sfrn ~/.dotfiles/home/.bash_aliases ~/.bash_aliases
ln -sfrn ~/.dotfiles/home/.tmux.conf ~/.tmux.conf
if [ "$1" = laptop ]; then
    ln -sfrn ~/.dotfiles/fastfetch/presets/full.jsonc ~/.config/fastfetch/config.jsonc
    ln -sfrn ~/.dotfiles/polybar/config_laptop.ini ~/.config/polybar/config.ini
    ln -sfrn ~/.dotfiles/conky/conky_laptop.conf ~/.config/conky/conky.conf
    ln -sfrn ~/.dotfiles/bspwm/bspwmrc_laptop ~/.config/bspwm/bspwmrc
    ln -sfrn ~/.dotfiles/home/laptop.bashrc ~/.bashrc
    ln -sfrn ~/.dotfiles/home/laptop.Xmodmap ~/.Xmodmap
else
    ln -sfrn ~/.dotfiles/fastfetch/presets/full.jsonc ~/.config/fastfetch/presets/full.jsonc
    ln -sfrn ~/.dotfiles/fastfetch/config.jsonc ~/.config/fastfetch/config.jsonc
    ln -sfrn ~/.dotfiles/polybar/config.ini ~/.config/polybar/config.ini
    ln -sfrn ~/.dotfiles/conky/conky.conf ~/.config/conky/conky.conf
    ln -sfrn ~/.dotfiles/bspwm/bspwmrc ~/.config/bspwm/bspwmrc
    ln -sfrn ~/.dotfiles/home/.bashrc ~/.bashrc
    ln -sfrn ~/.dotfiles/home/.Xmodmap ~/.Xmodmap
fi
