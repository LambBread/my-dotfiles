{
    config,
    pkgs,
    inputs,
    ...
}:
let
    colors = import ./colors.nix { inherit pkgs; };
    rowaita-icon-theme = pkgs.callPackage ./rowaita.nix { };
    # qogir-theme-fork = pkgs.callPackage ./qogir.nix { };
in
{
    environment.systemPackages = with pkgs; [
        sxhkd
        rofi
        conky
        dunst
        xsettingsd
        picom
        feh
        redshift
        xmodmap
        gsimplecal
        gowall
        (polybar.override {
            pulseSupport = true;
        })

        # qogir-theme-fork
        (inputs.qogir-theme-fork.lib.mkTheme {
            black = "#${colors.black}";
            red = "#${colors.red}";
            magenta = "#${colors.magenta}";
            l_red = "#${colors.l_red}";
            l_green = "#${colors.l_green}";
            l_white = "#${colors.l_white}";
        }).${pkgs.stdenv.hostPlatform.system}

        rowaita-icon-theme
        simp1e-cursors

        xdo
        xdotool
        libnotify

        librewolf
        libreoffice
        ghostty
        vlc
        ristretto
        gimp
        xarchiver
        atril
        baobab
        bleachbit
        prismlauncher
        pavucontrol
        xfce4-screenshooter

        fastfetch
        tty-clock
        vifm
        wget
        git
        zip
        unzip
        p7zip
        trash-cli
        ripgrep
        lazygit
        fd
        nixfmt

        tmux
        imagemagick
        tectonic
        mermaid-cli
        ghostscript
        tree-sitter

        ffmpegthumbnailer
        lxqt.lxqt-policykit
    ];
    fonts.packages = with pkgs; [
        nerd-fonts.monaspace
        # nerd-fonts._0xproto
        noto-fonts-color-emoji
    ];

    # programs.neovim = {
    #     enable = true;
    #     defaultEditor = true;
    # };
}
