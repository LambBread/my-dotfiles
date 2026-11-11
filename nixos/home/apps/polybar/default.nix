{
    config,
    pkgs,
    colors,
    personal,
    ...
}:
let
    desktop = {
        right-modules = "temperature cpu filesystem memory";
        left-modules = "nixbtw-fly proton-status tray pulseaudio bluetooth-battery";
        width = (1920 - (2 * colors.window_gap)); # 1920 - 24
        interface-type = "wired";
        label-connected = "%{T3}󰈀%{T1} %local_ip%";
        format-connected = "";
        disconnected-symbol = "󰈂";
    };
    laptop = {
        right-modules = "battery cpu filesystem memory";
        left-modules = "nixbtw-fly proton-status tray bspwm";
        width = (1366 - (2 * colors.window_gap)); # 1366 - 24
        interface-type = "wireless";
        label-connected = "%local_ip%";
        format-connected = "format-connected = %{T3}<ramp-signal>%{T1} <label-connected>";
        disconnected-symbol = "󰤮";
    };
    selectedConfig = if personal.DESK_NAME == "desktop" then desktop else laptop;
    leftWidth = 400;
    centerWidth = 250;
    rightWidth = 600;
    flyWidth = 500;
    centerOffset =
        ((leftWidth + colors.window_gap) + (selectedConfig.width - rightWidth) - centerWidth) / 2;

in
{
    xdg.configFile."polybar/config.ini".text = ''
        include-file = ~/.config/polybar/modules/modules.ini

        [bar/center]
        background = ''${colors.black}
        foreground = ''${colors.l-white}
        font-0 = "${colors.font}:size=10:weight=bold"
        font-1 = "${colors.font}:size=18:weight=bold;3"
        font-2 = "${colors.font}:size=14:weight=bold;2"
        font-3 = "${colors.font}:size=6"
        font-4 = "Noto Color Emoji:size=18:scale=8;2"
        font-5 = "${colors.font}:size=24:weight=bold;5"
        modules-center = date
        underline-size = 2
        padding = 2
        height = ${builtins.toString colors.bar_width}
        width = ${builtins.toString centerWidth}
        module-margin-left = 1
        module-margin-right = 1
        radius = ${builtins.toString colors.corner_radius}
        offset-y = ${builtins.toString colors.window_gap}
        offset-x = ${builtins.toString centerOffset}
        # (leftWidth + window_gap + width - rightWidth) - centerWidth / 2 -

        [bar/left]
        background = ''${colors.black}
        foreground = ''${colors.l-white}
        font-0 = "${colors.font}:size=10:weight=bold"
        font-1 = "${colors.font}:size=18:weight=bold;3"
        font-2 = "${colors.font}:size=14:weight=bold;2"
        font-3 = "${colors.font}:size=6"
        font-4 = "Noto Color Emoji:size=18:scale=8;2"
        font-5 = "${colors.font}:size=24:weight=bold;5"
        modules-center = ${selectedConfig.left-modules}
        underline-size = 2
        padding = 2
        height = ${builtins.toString colors.bar_width}
        width = ${builtins.toString leftWidth}
        module-margin-left = 1
        module-margin-right = 1
        radius = ${builtins.toString colors.corner_radius}
        offset-y = ${builtins.toString colors.window_gap}
        offset-x = ${builtins.toString colors.window_gap}

        [bar/right]
        background = ''${colors.black}
        foreground = ''${colors.l-white}
        font-0 = "${colors.font}:size=10:weight=bold"
        font-1 = "${colors.font}:size=18:weight=bold;3"
        font-2 = "${colors.font}:size=14:weight=bold;2"
        font-3 = "${colors.font}:size=6"
        font-4 = "Noto Color Emoji:size=18:scale=8;2"
        font-5 = "${colors.font}:size=24:weight=bold;5"
        modules-center = ${selectedConfig.right-modules}
        underline-size = 2
        padding = 2
        height = ${builtins.toString colors.bar_width}
        width = ${builtins.toString rightWidth}
        module-margin-left = 2
        module-margin-right = 2
        radius = ${builtins.toString colors.corner_radius}
        offset-y = ${builtins.toString colors.window_gap}
        offset-x = ${builtins.toString (selectedConfig.width - rightWidth)}

        [bar/fly]
        background = ''${colors.black}
        foreground = ''${colors.l-white}
        font-0 = "${colors.font}:size=10:weight=bold"
        font-1 = "${colors.font}:size=18:weight=bold;3"
        font-2 = "${colors.font}:size=14:weight=bold;2"
        font-3 = "${colors.font}:size=6"
        font-4 = "${colors.emoji_font}:size=18:scale=8;2"
        font-5 = "${colors.font}:size=24:weight=bold;5"
        modules-center = xwindow weather bspwm
        underline-size = 2
        padding = 2
        height = ${builtins.toString colors.bar_width}
        width = ${builtins.toString flyWidth}
        module-margin-left = 2
        module-margin-right = 0
        radius = ${builtins.toString colors.corner_radius}
        offset-y = ${builtins.toString (colors.bar_width + (2 * colors.window_gap))}
        offset-x = ${
            builtins.toString (
                (colors.window_gap + leftWidth) - (((flyWidth - centerOffset + colors.window_gap + leftWidth)) / 2)
            )
        }
        #override-redirect = true



        [bar/top]
        background = ''${colors.black}
        foreground = ''${colors.l-white}
        font-0 = "${colors.font}:size=10:weight=bold"
        font-1 = "${colors.font}:size=18:weight=bold;3"
        font-2 = "${colors.font}:size=14:weight=bold;2"
        font-3 = "${colors.font}:size=6"
        font-4 = "Noto Color Emoji:size=18:scale=8;2"
        font-5 = "${colors.font}:size=24:weight=bold;5"
        modules-right = ${selectedConfig.right-modules}
        modules-left = ${selectedConfig.left-modules}
        modules-center = date
        underline-size = 2
        padding = 2
        height = ${builtins.toString colors.bar_width}
        width = ${builtins.toString selectedConfig.width}
        module-margin-left = 1
        module-margin-right = 1
        radius = ${builtins.toString colors.corner_radius}
        offset-y = ${builtins.toString colors.window_gap}
        offset-x = ${builtins.toString colors.window_gap}

        [module/network]
        type = internal/network
        interface-type = ${selectedConfig.interface-type}
        interval = 10.0
        ramp-signal-0 = 󰤟
        ramp-signal-1 = 󰤢
        ramp-signal-2 = 󰤥
        ramp-signal-3 = 󰤨
        ${selectedConfig.format-connected}
        label-connected = ${selectedConfig.label-connected}
        label-connected-underline = ''${colors.l-magenta}
        label-disconnected = %{T3}${selectedConfig.disconnected-symbol}%{T1} %{F#${colors.white}}Disconnected
    '';

    xdg.configFile."polybar/scripts/batteryremaining.sh".text =
        builtins.replaceStrings
            [
                "cfb793"
                "d07271"
                "bc9ed0"
                "9fd356"
            ]
            [
                "${colors.white}"
                "${colors.l_red}"
                "${colors.l_magenta}"
                "${colors.l_green}"
            ]
            (builtins.readFile ./scripts/batteryremaining.sh);

    xdg.configFile."polybar/scripts/fly-toggle.sh".text = ''
        #!/bin/bash
        if pgrep -f 'polybar fly'; then
            pkill -f 'polybar fly'
            bspc config -m ${builtins.elemAt personal.MONITORS 0} top_padding ${
                builtins.toString (colors.bar_width + colors.window_gap)
            }
        else
            polybar fly & 
            bspc config -m ${builtins.elemAt personal.MONITORS 0} top_padding ${
                builtins.toString (2 * (colors.bar_width + colors.window_gap))
            }
        fi
    '';

    xdg.configFile."polybar/scripts/proton-status.sh".text = ''
        #!/bin/sh

        if protonvpn status | grep -q 'Connected'; then
            echo '%{F#${colors.l_green}}%{F-}' 
        else
            echo '%{F#${colors.l_red}}%{F-}'
        fi
    '';

    xdg.configFile."polybar/scripts/toggle-proton.sh".text = ''
        #!/bin/sh

        if protonvpn status | grep -q 'Connected'; then
            protonvpn disconnect
        else
            protonvpn connect
        fi
    '';
    xdg.configFile."polybar/scripts/batteryremaining.sh".executable = true;
    xdg.configFile."polybar/scripts/fly-toggle.sh".executable = true;
    xdg.configFile."polybar/scripts/proton-status.sh".executable = true;
    xdg.configFile."polybar/scripts/toggle-proton.sh".executable = true;

    xdg.configFile."polybar/modules/commonmods.ini".source = ./modules/commonmods.ini;

    xdg.configFile."polybar/modules/modules.ini".text = ''
        include-file = ~/.config/polybar/modules/commonmods.ini
           
        [colors]
        black = #aa${colors.black}
        black-alt = #aa${colors.black_alt}
        red = #${colors.red}
        magenta = #aa${colors.magenta}
        white = #${colors.white}
        blue = #aa${colors.blue}
        l-red = #${colors.l_red}
        l-green = #${colors.l_green}
        l-blue = #${colors.l_blue}
        l-magenta = #${colors.l_magenta}
        l-white = #${colors.l_white}

        [module/weather]
        type = custom/script
        exec = curl -s "wttr.in/${personal.LOCATION.lat},${personal.LOCATION.lon}?format=%20%c%t&m"
        interval = 120
        exec-if = ping -c 1 wttr.in
        click-left = xdg-open "${personal.WEATHER_LINK}"



    '';
}
