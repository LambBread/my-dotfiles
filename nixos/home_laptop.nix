{ config, pkgs, ... }:
let
    dotfilesDir = "${config.home.homeDirectory}/.dotfiles";
    links = 
    {
        ".bashrc" = "home/laptop.bashrc";
        ".bash_aliases" = "home/.bash_aliases";
        ".tmux.conf" = "home/.tmux.conf";
        ".Xmodmap" = "home/laptop.Xmodmap";
        ".config/bspwm/bspwmrc" = "config/bspwm/bspwmrc_laptop";
        ".config/conky/conky.conf" = "config/conky/conky_laptop.conf";
        ".config/dunst" = "config/dunst";
        ".config/fastfetch/config.jsonc" = "config/fastfetch/presets/nixos.jsonc";
        ".config/fastfetch/presets" = "config/fastfetch/presets";
        ".config/fastfetch/logos" = "config/fastfetch/logos";
        ".config/ghostty" = "config/ghostty";
        ".config/gtk-3.0" = "config/gtk-3.0";
        ".config/nvim" = "config/nvim";
        ".config/picom" = "config/picom";
        ".config/polybar/config.ini" = "config/polybar/config_laptop.ini";
        ".config/polybar/scripts" = "config/polybar/scripts";
        ".config/redshift" = "config/redshift";
        ".config/sxhkd" = "config/sxhkd";
        ".config/xsettingsd" = "config/xsettingsd";
    };
in
{
    home.stateVersion = "26.05";
    home.packages = with pkgs;
    [

    ];
    home.activation.makeDirectories = ''
        run mkdir -p ${config.home.homeDirectory}/.config
        run mkdir -p ${config.home.homeDirectory}/.config/bspwm
        run mkdir -p ${config.home.homeDirectory}/.config/conky
        run mkdir -p ${config.home.homeDirectory}/.config/fastfetch
        run mkdir -p ${config.home.homeDirectory}/.config/polybar
    '';
    home.file = builtins.mapAttrs (key: value: {
        source = config.lib.file.mkOutOfStoreSymlink "${dotfilesDir}/${value}";
    }) links;
}
