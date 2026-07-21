#!/bin/sh

mkdir -p ~/Pictures
mkdir -p ~/Pictures/wallpaper
mkdir -p ~/.config/conky
mkdir -p ~/.config/bspwm
mkdir -p ~/.config/polybar
mkdir -p ~/.config/fastfetch
mkdir -p ~/.config/fastfetch/presets
curl https://www.socwall.com/images/wallpapers/34499-1920x1200.jpg -o ~/Pictures/wallpaper/wallpaper.jpg


ln -sfrn ~/.dotfiles/config/alacritty ~/.config/alacritty
ln -sfrn ~/.dotfiles/config/cortile ~/.config/cortile
ln -sfrn ~/.dotfiles/config/ghostty ~/.config/ghostty
ln -sfrn ~/.dotfiles/config/gtk-3.0 ~/.config/gtk-3.0
ln -sfrn ~/.dotfiles/config/nvim ~/.config/nvim
ln -sfrn ~/.dotfiles/config/picom ~/.config/picom
ln -sfrn ~/.dotfiles/config/redshift ~/.config/redshift
ln -sfrn ~/.dotfiles/config/sxhkd ~/.config/sxhkd
ln -sfrn ~/.dotfiles/config/xsettingsd ~/.config/xsettingsd
ln -sfrn ~/.dotfiles/config/dunst ~/.config/dunst
ln -sfrn ~/.dotfiles/config/polybar/scripts ~/.config/polybar/scripts
ln -sfrn ~/.dotfiles/config/fastfetch/logos ~/.config/fastfetch/logos
ln -sfrn ~/.dotfiles/config/fastfetch/presets/default.jsonc ~/.config/fastfetch/presets/default.jsonc
ln -sfrn ~/.dotfiles/config/fastfetch/presets/full.jsonc ~/.config/fastfetch/presets/full.jsonc
ln -sfrn ~/.dotfiles/home/.bash_aliases ~/.bash_aliases
ln -sfrn ~/.dotfiles/home/.tmux.conf ~/.tmux.conf
if [ "$1" = laptop ]; then
    ln -sfrn ~/.dotfiles/config/fastfetch/presets/nixos.jsonc ~/.config/fastfetch/config.jsonc
    ln -sfrn ~/.dotfiles/config/polybar/config_laptop.ini ~/.config/polybar/config.ini
    ln -sfrn ~/.dotfiles/config/conky/conky_laptop.conf ~/.config/conky/conky.conf
    ln -sfrn ~/.dotfiles/config/bspwm/bspwmrc_laptop ~/.config/bspwm/bspwmrc
    ln -sfrn ~/.dotfiles/home/laptop.bashrc ~/.bashrc
    ln -sfrn ~/.dotfiles/home/laptop.Xmodmap ~/.Xmodmap
else
    ln -sfrn ~/.dotfiles/config/fastfetch/presets/nixos.jsonc ~/.config/fastfetch/presets/nixos.jsonc
    ln -sfrn ~/.dotfiles/config/fastfetch/config.jsonc ~/.config/fastfetch/config.jsonc
    ln -sfrn ~/.dotfiles/config/polybar/config.ini ~/.config/polybar/config.ini
    ln -sfrn ~/.dotfiles/config/conky/conky.conf ~/.config/conky/conky.conf
    ln -sfrn ~/.dotfiles/config/bspwm/bspwmrc ~/.config/bspwm/bspwmrc
    ln -sfrn ~/.dotfiles/home/.bashrc ~/.bashrc
    ln -sfrn ~/.dotfiles/home/.Xmodmap ~/.Xmodmap
fi
