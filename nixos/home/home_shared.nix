{ config, pkgs, ... }:
let
    colors = import ../modules/colors.nix;
    personal = import ../personal.nix;
in
{

    imports = [
        ./config/bash.nix
        ./config/bspwm.nix
        ./config/conky.nix
        ./config/fastfetch.nix
        ./config/ghostty.nix
        ./config/gtk.nix
        ./config/picom.nix
        ./config/polybar.nix
        ./config/rofi.nix
        ./config/thunar.nix
    ];
    home.activation.makeDirectories = ''
        run mkdir -p ${config.home.homeDirectory}/Pictures/wallpaper
        run ln -sf /srv/background.png \
        ${config.home.homeDirectory}/Pictures/wallpaper/wallpaper.png
    '';

    xdg.userDirs = {
        enable = true;
        createDirectories = true;

        desktop = "${config.home.homeDirectory}/Desktop";
        download = "${config.home.homeDirectory}/Downloads";
        documents = "${config.home.homeDirectory}/Documents";
        music = "${config.home.homeDirectory}/Music";
        pictures = "${config.home.homeDirectory}/Pictures";
        videos = "${config.home.homeDirectory}/Videos";
        extraConfig = {
            XDG_SCREENSHOTS_DIR = "${config.home.homeDirectory}/Pictures/Screenshots";
        };
    };

    xdg.configFile."mimeapps.list".force = true;
    xdg.mimeApps = {
        enable = true;
        defaultApplications = {
            "text/html" = "librewolf.desktop";
            "x-scheme-handler/http" = "librewolf.desktop";
            "x-scheme-handler/https" = "librewolf.desktop";
            "x-scheme-handler/about" = "librewolf.desktop";
            "x-scheme-handler/unknown" = "librewolf.desktop";
            "application/zip" = [ "xarchiver.desktop" ];
            "application/x-zip-compressed" = [ "xarchiver.desktop" ];
            "image/jpeg" = "org.xfce.ristretto.desktop";
            "image/png" = "org.xfce.ristretto.desktop";
            "image/gif" = "org.xfce.ristretto.desktop";
            "image/webp" = "org.xfce.ristretto.desktop";
            "image/svg+xml" = "org.xfce.ristretto.desktop";
        };
    };

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

    services.blueman-applet.enable = true;
    services.lxqt-policykit-agent.enable = true;
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
        mainwindow_yoffset = 90
        close_on_unfocus = 1
    '';

    services.redshift = {
        enable = true;
        temperature = {
            day = 6400;
            night = 3600;
        };
        provider = "manual";
        latitude = "${personal.LOCATION.lat}";
        longitude = "${personal.LOCATION.lon}";
        tray = true;
    };

}
