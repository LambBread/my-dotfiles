{ config, pkgs, ... }:
let
    personal = import ../../personal.nix;
    colors = import ../../modules/colors.nix { inherit pkgs; };
in
{
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
        mainwindow_yoffset = 78
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
