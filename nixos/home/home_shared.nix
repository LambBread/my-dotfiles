{ config, pkgs, ... }:
{

    imports = [
        ./config/bash.nix
        ./config/bspwm.nix
        ./config/conky.nix
        ./config/fastfetch.nix
        ./config/ghostty.nix
        ./config/gtk.nix
        ./config/misc.nix
        ./config/picom.nix
        ./config/polybar.nix
        ./config/rofi.nix
        ./config/thunar.nix
        ./config/xdg.nix
    ];
    home.activation.makeDirectories = ''
        run mkdir -p ${config.home.homeDirectory}/Pictures/wallpaper
        run ln -sf /srv/background.png \
        ${config.home.homeDirectory}/Pictures/wallpaper/wallpaper.png
    '';

}
