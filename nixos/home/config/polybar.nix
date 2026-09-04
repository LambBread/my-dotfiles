{ config, pkgs, ... }:
let
    colors = import ../../modules/colors.nix { inherit pkgs; };
    personal = import ../../personal.nix;
    desktop = {
        right-modules = "battery weather temperature memory";
        left-modules = "nixbtw-fly proton-status tray";
        width = "1896"; # 1920 - 24
        interface-type = "wired";
        label-connected = "%{T3}󰈀%{T1} %local_ip%";
        format-connected = "";
        disconnected-symbol = "󰈂";
    };
    laptop = {
        right-modules = "battery weather memory";
        left-modules = "nixbtw-fly tray";
        width = "1342"; # 1366 - 24
        interface-type = "wireless";
        label-connected = "%local_ip%";
        format-connected = "format-connected = %{T3}<ramp-signal>%{T1} <label-connected>";
        disconnected-symbol = "󰤮";
    };
    selectedConfig = if personal.DESK_NAME == "desktop" then desktop else laptop;
in
{
    xdg.configFile."polybar/config.ini".text = ''
        include-file = ~/.config/polybar/modules/modules.ini

        [bar/top]
        background = ''${colors.blue}
        foreground = ''${colors.l-white}
        font-0 = "${colors.font}:size=11:weight=bold"
        font-1 = "${colors.font}:size=18:weight=bold;3"
        font-2 = "${colors.font}:size=14:weight=bold;2"
        font-3 = "${colors.font}:size=6"
        font-4 = "Noto Color Emoji:size=18:scale=8;2"
        font-5 = "${colors.font}:size=24:weight=bold;5"
        modules-right = ${selectedConfig.right-modules}
        modules-left = ${selectedConfig.left-modules}
        modules-center = bspwm
        underline-size = 2
        padding = 2
        height = 32
        width = ${selectedConfig.width}
        module-margin-left = 2
        module-margin-right = 0
        radius = 20
        offset-y = 12
        offset-x = 12

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

    xdg.configFile."polybar/scripts/batteryremaining.sh".text = ''
        #!/bin/sh

        connected_devices=$(bluetoothctl devices Connected | grep "Device " | awk '{print $2}')

        if [ -z "$connected_devices" ]; then
            echo "%{F#${colors.white}}%{T2}󰟎%{T1} N/A%%{F-}"
            exit 0
        fi

        battery_info=""
        for mac in $connected_devices; do
            battery=$(echo "info $mac" | bluetoothctl | grep "Battery Percentage" | sed 's/.*(\([0-9]*\)).*/\1/')
            name=$(echo "info $mac" | bluetoothctl | grep "Name" | cut -d: -f2 | xargs)
            
            if [ -n "$battery" ] && [ "$battery" != "(unknown)" ]; then
                battery_info="''${battery}"
                break  # Show first matching headphones
            fi
        done

        if [ -n "$battery_info" ]; then
            if [ "$battery_info" -le "20" ]; then
                echo "%{F#${colors.red}}%{T2}󰥇%{F-}%{T1} $battery_info%"
            elif [ "$battery_info" -le "40" ]; then
                echo "%{F#${colors.red}}%{T2}󰥀%{F-}%{T1} $battery_info%"
            elif [ "$battery_info" -le "60" ]; then
                echo "%{F#${colors.l_magenta}}%{T2}󰥂%{F-}%{T1} $battery_info%"
            elif [ "$battery_info" -le "80" ]; then
                echo "%{F#${colors.l_magenta}}%{T2}󰥄%{F-}%{T1} $battery_info%"
            else
                echo "%{F#${colors.l_green}}%{T2}󰥈%{F-}%{T1} $battery_info%"
            fi
        else
            echo "%{F#${colors.white}}%{T2}󰥊%{F-}%{T1} --%"
        fi
    '';

    xdg.configFile."polybar/scripts/fly-toggle.sh".text = ''
        #!/bin/bash
        if pgrep -f 'polybar fly'; then
            pkill -f 'polybar fly'
        else
            polybar fly & 
        fi
    '';

    xdg.configFile."polybar/scripts/proton-status.sh".text = ''
        #!/bin/sh

        if protonvpn status | grep -q 'Connected'; then
            echo '%{F#${colors.l_green}}%{F-}' 
        else
            echo '%{F#${colors.red}}%{F-}'
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

    xdg.configFile."polybar/modules/modules.ini".text = ''
           
        [colors]
        black = #90${colors.black}
        red = #${colors.red}
        magenta = #90${colors.magenta}
        white = #${colors.white}
        blue = #90${colors.blue}
        l-green = #${colors.l_green}
        l-blue = #${colors.l_blue}
        l-magenta = #${colors.l_magenta}
        l-white = #${colors.l_white}

        [bar/fly]
        background = ''${colors.blue}
        foreground = ''${colors.l-white}
        font-0 = "${colors.font}:size=11:weight=bold"
        font-1 = "${colors.font}:size=18:weight=bold;3"
        font-2 = "${colors.font}:size=14:weight=bold;2"
        font-3 = "${colors.font}:size=6"
        font-4 = "${colors.emoji_font}:size=18:scale=8;2"
        font-5 = "${colors.font}:size=24:weight=bold;5"
        modules-center = xwindow date time bluetooth-battery pulseaudio
        underline-size = 2
        padding = 2
        height = 32
        width = 600
        module-margin-left = 2
        module-margin-right = 0
        radius = 20
        offset-y = 56
        offset-x = 10
        override-redirect = true

        [module/nixbtw-fly]
        inherit = module/nixbtw
        click-left = ~/.config/polybar/scripts/fly-toggle.sh

        [module/temperature]
        type = internal/temperature
        interval = 0.5
        hwmon-path = /sys/devices/platform/coretemp.0/hwmon/hwmon1/temp1_input
        label = %{T3}%{T1} %temperature-c%
        label-warn = %{T3}%{T1} %temperature-c%
        label-warn-foreground = ''${colors.red}

        [module/weather]
        type = custom/script
        exec = curl -s "wttr.in/${personal.LOCATION.lat},${personal.LOCATION.lon}?format=%20%c%t&m"
        interval = 120
        exec-if = ping -c 1 wttr.in
        click-left = xdg-open "${personal.WEATHER_LINK}"
        label-underline = ''${colors.l-magenta}

        [module/nixbtw]
        type = custom/text
        label = ""
        label-font = 6
        label-foreground = ''${colors.l-blue}


        [module/bluetooth-battery]
        type = custom/script
        exec = ~/.config/polybar/scripts/batteryremaining.sh
        interval = 10
        label = %output%
        format-background = ''${colors.blue}
        format-foreground = ''${colors.l-white}

        [module/proton-status]
        type = custom/script
        exec = ~/.config/polybar/scripts/proton-status.sh
        interval = 7
        label = %output%
        label-font = 2
        format-background = ''${colors.blue}
        format-foreground = ''${colors.l-white}
        click-left = ~/.config/polybar/scripts/toggle-proton.sh


        [module/date]
        type = internal/date
        date = %{A1: gsimplecal &:}%{T2}%{T1} %Y-%m-%d%{A}
        label-underline = ''${colors.l-magenta}
        # click-left = gsimplecal

        [module/time]
        type = internal/date
        date = %{A1: ghostty --command='tty-clock -C 5 -s -c' &:}%{T3}%{T1} %H:%M:%S%{A}
        label-underline = ''${colors.l-magenta}
        # click-left = ghostty --command='tty-clock -C 5 -s -c'

        [module/tray]
        type = internal/tray

        [module/memory]
        type = internal/memory
        interval = 0.5
        format = <label>
        label = %{T2}%{T1} %used%/%total%

        [module/battery]
        type = internal/battery
        ramp-capacity-0 = 󰂃
        ramp-capacity-1 = 󰁺
        ramp-capacity-2 = 󰁻
        ramp-capacity-3 = 󰁼
        ramp-capacity-4 = 󰁽
        ramp-capacity-5 = 󰁾
        ramp-capacity-6 = 󰁿
        ramp-capacity-7 = 󰂀
        ramp-capacity-8 = 󰂁
        ramp-capacity-9 = 󰂂

        ramp-capacity-0-font = 2
        ramp-capacity-1-font = 2
        ramp-capacity-2-font = 2
        ramp-capacity-3-font = 2
        ramp-capacity-4-font = 2
        ramp-capacity-5-font = 2
        ramp-capacity-6-font = 2
        ramp-capacity-7-font = 2
        ramp-capacity-8-font = 2
        ramp-capacity-9-font = 2

        format-charging = <ramp-capacity> <label-charging>
        format-discharging = <ramp-capacity> <label-discharging>
        format-full = 󰁹 <label-full>

        [module/xwindow]
        type = internal/xwindow
        format = <label>
        format-background = ''${colors.blue}
        format-foreground = ''${colors.l-white}
        format-padding = 2
        label = %title%
        label-underline = ''${colors.l-magenta}
        label-maxlen = 15
        label-empty = Desktop
        label-empty-foreground = ''${colors.white}

        [module/bspwm]
        type = internal/bspwm
        pin-workspaces = false
        enable-click = true
        label-focused = "%{T4} %{T1}%name%%{T4} %{T1}"
        label-focused-background = ''${colors.magenta}
        label-focused-foreground = ''${colors.l-blue}
        label-focused-underline = ''${colors.l-magenta}

        label-occupied = "%{T4} %{T1}%name%%{T4} %{T1}"

        label-dimmed = "%{T4} %{T1}%name%%{T4} %{T1}"
        label-dimmed-foreground = ''${colors.white}


        label-urgent = "%{T4} %{T1}%name%%{T4} %{T1}"
        label-urgent-background = ''${colors.red}

        label-empty = "%{T4} %{T1}%name%%{T4} %{T1}"
        label-empty-foreground = ''${colors.l-green}

        [module/pulseaudio]
        type = internal/pulseaudio
        use-ui-max = false
        interval = 5
        ramp-volume-0 = %{T2}󰕿%{T1}
        ramp-volume-1 = %{T2}󰖀%{T1} 
        ramp-volume-2 = %{T2}󰕾%{T1}
        format-volume = <ramp-volume> <label-volume>
        label-muted = %{T2}%{T1} muted
        format-volume-underline = ''${colors.l-magenta}
        click-right = pavucontrol

        bar-volume-width = 10
        bar-volume-foreground-0 = ''${colors.l-magenta}
        bar-volume-foreground-1 = ''${colors.l-magenta}
        bar-volume-foreground-2 = ''${colors.l-green}
        bar-volume-foreground-3 = ''${colors.l-green}
        bar-volume-foreground-4 = ''${colors.red}
        bar-volume-gradient = true
        bar-volume-indicator = ┃
        bar-volume-fill = ━
        bar-volume-fill-font = 1
        bar-volume-empty = -
        bar-volume-empty-font = 1
        bar-volume-empty-foreground = ''${colors.white}
    '';
}
