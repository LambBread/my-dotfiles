{
    config,
    pkgs,
    inputs,
    colors,
    ...
}:
# let
#     rowaita-icon-theme = pkgs.callPackage ./rowaita.nix { };
# in
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

        (inputs.rowaita-icon-theme.lib.mkTheme {
            magenta = "#${colors.magenta}";
            l_magenta = "#${colors.l_magenta}";
            l_white = "#${colors.l_white}";
        }).${pkgs.stdenv.hostPlatform.system}

        simp1e-cursors

        xdo
        xdotool
        libnotify

        librewolf
        libreoffice
        # discord
        ghostty
        vlc
        ristretto
        gimp
        xarchiver
        atril
        baobab
        bleachbit
        luckybackup
        prismlauncher
        pavucontrol
        xfce4-screenshooter

        fastfetch
        hyfetch
        tty-clock
        vifm
        wget
        git

        zip
        unzip
        p7zip
        gnutar
        gzip
        bzip2
        xz

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
    programs.thunar = {
        enable = true;
        plugins = with pkgs; [
            thunar-archive-plugin
            thunar-volman
        ];
    };

    nixpkgs.overlays = [
        (final: prev: {
            thunar-archive-plugin = prev.thunar-archive-plugin.overrideAttrs (old: {
                postInstall = (old.postInstall or "") + ''
                    mkdir -p $out/libexec/thunar-archive-plugin
                    cp ${final.xarchiver}/libexec/thunar-archive-plugin/xarchiver.tap $out/libexec/thunar-archive-plugin/
                '';
            });
        })
    ];

    # programs.neovim = {
    #     enable = true;
    #     defaultEditor = true;
    # };
}
