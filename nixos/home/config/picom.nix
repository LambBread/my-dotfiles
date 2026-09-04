{ config, pkgs, ... }:
{
    services.picom = {
        enable = true;
        backend = "glx";
        vSync = true;
        shadow = true;
        inactiveOpacity = 1.0;
        activeOpacity = 1;
        menuOpacity = 0.8;
        fade = true;
        fadeSteps = [
            0.07
            0.07
        ];
        fadeExclude = [ ];
        shadowOpacity = 0.4;
        shadowOffsets = [
            (-50)
            (-50)
        ];
        wintypes = {
            dock = {
                shadow = true;
            };
            dnd = {
                shadow = false;
            };
            popup_menu = {
                opacity = 1;
            };
            dropdown_menu = {
                opacity = 1;
            };
        };
        shadowExclude = [

            "_GTK_FRAME_EXTENTS@"
            "name = 'Notification'"
            "name = 'Plank'"
            "name = 'Docky'"
            "name = 'Kupfer'"
            "name = 'Pensela'"
            "name = 'Drawing Board'"
            "name = 'VirtualBox'"
            "name = 'VirtualBoxVM'"
            "name = 'Negatron v0.100.1' && argb"
            "name = 'xfce4-panel'"
            "name ?= 'xfwm4' && argb"
            "class_g = 'Conky'"
            "class_g = 'Kupfer'"
            "class_g = 'Synapse'"
            "class_g ?= 'Notify-osd'"
            "class_g ?= 'Cairo-dock'"
            "class_g = 'Cairo-clock'"
            "class_g ?= 'Xfce4-notifyd'"
            "class_g = 'Polybar'"
            "class_g = 'Thunderbird' && argb"
            "class_g = 'Telegram' && argb"
            "name ?= 'Thunderbird' && (window_type = 'utility' || window_type = 'popup_menu')"
            "class_g ?= 'Thunderbird' && class_i = 'Popup' && argb"
            "class_g = 'firefox' && (window_type = 'utility' || window_type = 'popup_menu') && argb"
            "class_g = 'Firefox' && (window_type = 'utility' || window_type = 'popup_menu') && argb"
            "class_g = 'firefox-esr' && (window_type = 'utility' || window_type = 'popup_menu') && argb"
            "class_g = 'Firefox-esr' && (window_type = 'utility' || window_type = 'popup_menu') && argb"
            "class_g = 'Tor Browser' && (window_type = 'utility') && argb"
            "class_g = 'Navegador Tor' && (window_type = 'utility' || window_type = 'popup_menu') && argb"
            "class_g = 'Thunderbird' && (window_type = 'utility' || window_type = 'popup_menu') && argb"
            "class_g = 'Mozilla Thunderbird' && (window_type = 'utility' || window_type = 'popup_menu') && argb"
            "class_g ?= 'Xfce4-power-manager'"
            "class_g ?= 'vokoscreen' && argb"
            "name = 'Área'"
            "name *= 'Cuenta regresiva'"
            "_NET_WM_WINDOW_TYPE *= '_KDE_NET_WM_WINDOW_TYPE_OVERRIDE'"
        ];
        opacityRules = [

            "80:class_g = 'Thunar'"
            "80:class_g ?= 'xfwm4' && argb"
        ];
        settings = {
            glx-copy-from-front = false;
            use-damage = false;
            shadow-radius = 35;
            frame-opacity = 0.8;
            inactive-opacity-override = false;
            corner-radius = 20;
            round-borders = 1;
            rounded-corners-exclude = [
                "window_type = 'desktop'"
                "class_g = 'Polybar'"
            ];
            blur-method = "dual_kawase";
            blur-strength = 10;
            inactive-dim = 0.1;

            blur-kern = "9x9gaussian";

            blur-background-exclude = [
                "class_g = 'Peek'"
                "class_g = 'Pensela'"
                "class_g ?= 'xfce4-screenshooter'"
                "name = 'Drawing Board'"
                "window_type = 'dock'"
                "window_type = 'dropdown_menu'"
                "window_type = 'combo'"
                "window_type = 'popup_menu'"
                "window_type = 'utility'"
                "window_type = 'desktop'"
                "_GTK_FRAME_EXTENTS@"
            ];
            opacity-exclude = [
                "name = 'Stratagus'"
            ];
            log-level = "warn";

            mark-wmwin-focused = true;
            mark-ovredir-focused = true;
            detect-rounded-corners = true;
            detect-client-opacity = true;
            focus-exclude = [ "class_g = 'Cairo-clock'" ];
            detect-transient = true;
            detect-client-leader = true;
            invert-color-include = [ ];
        };

        extraConfig = ''
            animations = (
            {
              triggers = ["open", "show"];
              preset = "appear";
              direction = "up";
              duration = 0.2;
              scale = 0.8;
            },
            {
                triggers = ["close", "hide"];
                preset = "disappear";
                direction = "up";
                duration = 0.2;
                scale = 0.8;
            },
            {
                triggers = ["geometry"];
                preset = "geometry-change";
                duration = 0.2;
            });

        '';
    };
}
