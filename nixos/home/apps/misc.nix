{
    config,
    pkgs,
    colors,
    personal,
    ...
}:
{
    qt = {
        enable = true;
        platformTheme.name = "kvantum";
        style.name = "kvantum";
    };

    xdg.configFile."Kvantum/ArcDark".source = "${pkgs.arc-kde-theme}/share/Kvantum/ArcDark";
    xdg.configFile."Kvantum/kvantum.kvconfig".text = ''
        [General]
        theme=ArcDark
    '';

    programs.ssh = {
        enable = true;
        enableDefaultConfig = false;
        settings = {
            "github.com" = {
                HostName = "github.com";
                User = "git";
                IdentityFile = "~/.ssh/gh_key2";
                IdentitiesOnly = "yes";
            };
        };
    };

    programs.git = {
        enable = true;
        settings = {
            user = {
                name = "${personal.USERNAME}";
                email = "${personal.EMAIL}";
                signingkey = "${config.home.homeDirectory}/.ssh/gh_key.pub";
            };
            signing = {
                key = "${config.home.homeDirectory}/.ssh/gh_key.pub";
                signByDefault = true;
                format = "ssh";
            };
            commit = {
                gpgSign = true;
            };
            gpg = {
                format = "ssh";
            };
        };
    };

    services.gnome-keyring = {
        enable = true;
        components = [
            "pkcs11"
            "secrets"
            "ssh"
        ];
    };

    services.blueman-applet.enable = true;
    #services.lxqt-policykit-agent.enable = true;
    services.polkit-gnome.enable = true;
    services.xsettingsd = {
        enable = true;
        settings = {
            "Net/ThemeName" = "${colors.theme}";
            "Net/IconThemeName" = "${colors.icon_theme}";
            "Gtk/CursorThemeName" = "${colors.cursor_theme}";
            "Gtk/FontName" = "${colors.font} 11";
        };
    };

    xdg.configFile."gsimplecal/config".text = ''
        show_week_numbers = 1
        mainwindow_yoffset = ${builtins.toString ((colors.bar_width * 2) + colors.window_gap + 2)}
    '';

    services.gammastep = {
        enable = true;
        temperature = {
            day = 6400;
            night = 3600;
        };
        provider = "manual";
        settings.general = {
            adjustment-method = "randr";
        };
        latitude = "${personal.LOCATION.lat}";
        longitude = "${personal.LOCATION.lon}";
        tray = true;
    };
}
