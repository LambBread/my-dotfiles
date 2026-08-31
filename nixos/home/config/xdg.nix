{ config, pkgs, ... }:
{

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
}
