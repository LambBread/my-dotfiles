{ config, pkgs, ... }:
let
    rowaita-icon-theme = pkgs.callPackage ./rowaita.nix { };
    qogir-theme-fork = pkgs.callPackage ./qogir.nix { };
in
{
    environment.systemPackages = with pkgs; [
        sxhkd
        rofi
        conky
        xdo
        xdotool
        libnotify
        (polybar.override {
            pulseSupport = true;
        })
        dunst
        xsettingsd
        baobab
        librewolf
        libreoffice
        fastfetch
        wget
        git
        picom
        xmodmap
        ghostty
        tty-clock
        p7zip
        xarchiver
        zip
        unzip
        gsimplecal
        qogir-theme-fork
        rowaita-icon-theme
        simp1e-cursors
        redshift
        # diodon
        # clipmenu
        # dmenu
        bleachbit
        prismlauncher
        feh
        vlc
        gimp
        pavucontrol
        xfce4-screenshooter
        tmux
        (thunar.override {
            thunarPlugins = with pkgs; [
                thunar-archive-plugin
                thunar-volman
            ];
        })
        # file-roller
        ffmpegthumbnailer
        ristretto
        atril
        lxqt.lxqt-policykit
        nixfmt
        tree-sitter
    ];
    fonts.packages = with pkgs; [
        nerd-fonts.monaspace
        noto-fonts-color-emoji
    ];

    programs.neovim = {
        enable = true;
        defaultEditor = true;
    };
}
