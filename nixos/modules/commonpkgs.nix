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
        xmodmap
        gowall

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
        arc-kde-theme
        libsForQt5.qtstyleplugin-kvantum
        kdePackages.qtstyleplugin-kvantum

        xdo
        xdotool
        libnotify

        xarchiver
        baobab
        bleachbit
        luckybackup
        pavucontrol
        xfce4-screenshooter

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

        imagemagick
        tectonic
        mermaid-cli
        ghostscript
        tree-sitter

        ffmpegthumbnailer
        #lxqt.lxqt-policykit
        polkit_gnome
        seahorse
        libsecret

        proton-vpn-cli
        proton-vpn
        dnsmasq

    ];
    fonts.packages = with pkgs; [
        nerd-fonts.monaspace
        # nerd-fonts._0xproto
        noto-fonts-color-emoji
        corefonts
    ];
    programs.thunar = {
        enable = true;
        plugins = with pkgs; [
            thunar-archive-plugin
            thunar-volman
        ];
    };
    services.flatpak.enable = true;
    services.flatpak.remotes = [
        {
            name = "flathub";
            location = "https://dl.flathub.org/repo/flathub.flatpakrepo";
        }
    ];

    services.flatpak.packages = [
        "org.gtk.Gtk3theme.Adwaita-dark"
        {
            appId = "io.github.crealityofficial.CrealityPrint";
            sha256 = "sha256-UKKBrSHnPHEy7SDxMBrIzHyMtN++prfWr76t5qiFbZE=";
            bundle = "${pkgs.fetchurl {
                url = "https://github.com/CrealityOfficial/CrealityPrint/releases/download/v7.3.0/CrealityPrint-Linux-flatpak_V7.3.0-Release_x86_64.flatpak";
                sha256 = "sha256-UKKBrSHnPHEy7SDxMBrIzHyMtN++prfWr76t5qiFbZE=";
            }}";
        }
    ];

    services.flatpak.overrides.global = {
        Context = {
            filesystems = [
                "/nix/store:ro"
                "xdg-themes:ro"
                "xdg-icons:ro"
            ];
        };
        Environment = {
            GTK_THEME = "Adwaita-dark";
        };
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
