{
    config,
    pkgs,
    ...
}:
let
    colors = import ../../modules/colors.nix { inherit pkgs; };
    personal = import ../../personal.nix;
    desktop = {
        monitors = {
            "${builtins.elemAt personal.MONITORS 0}" = [
                "󰇊"
                "󰇋"
                "󰇌"
                "󰇍"
                "󰇎"
                "󰇏"
            ];
            "${builtins.elemAt personal.MONITORS 1}" = [
                "󱅊"
                "󱅋"
                "󱅌"
                "󱅍"
                "󱅎"
                "󱅏"
            ];
        };
        extra = ''
            xrandr --output ${builtins.elemAt personal.MONITORS 0} --primary --output \
            ${builtins.elemAt personal.MONITORS 1} --right-of ${builtins.elemAt personal.MONITORS 0}
            xmodmap ~/.Xmodmap
            pgrep -x greenclip || greenclip daemon &
            pkill conky
            (sleep 5; xdo lower -N Conky) &
            pgrep -x polybar > /dev/null || polybar top &
            feh --bg-fill ~/Pictures/wallpaper/wallpaper.png
            nm-applet &
            protonvpn connect &
        '';
    };
    laptop = {
        monitors = {
            "${personal.SHORT_NAME}" = [
                "󰇊"
                "󰇋"
                "󰇌"
                "󰇍"
                "󰇎"
                "󰇏"
                "󱅊"
                "󱅋"
                "󱅌"
                "󱅍"
                "󱅎"
                "󱅏"
            ];
        };
        extra = ''
            xmodmap ~/.Xmodmap
            pgrep -x greenclip || greenclip daemon &
            pkill conky
            (sleep 5; xdo lower -N Conky) &
            pgrep -x polybar > /dev/null || polybar top &
            feh --bg-fill ~/Pictures/wallpaper/wallpaper.png
            nm-applet &
        '';
    };
    monitors = if personal.DESK_NAME == "desktop" then desktop.monitors else laptop.monitors;
    extraConfigEarly = if personal.DESK_NAME == "desktop" then desktop.extra else laptop.extra;
in
{
    services.dunst = {
        enable = true;
        settings = {
            global = {
                icon_theme = "${colors.icon_theme}";
                enable_recursive_icon_lookup = true;
                background = "#${colors.blue}";
                font = "${colors.font} 11";
                frame_width = 0;
                sort = true;
                padding = 6;
                horizontal_padding = 12;
                transparency = 20;
                alignment = "center";
                timeout = 5;
            };
        };
    };

    xsession.windowManager.bspwm = {
        enable = true;
        inherit monitors;
        inherit extraConfigEarly;
        settings = {
            border_width = 4;
            window_gap = 12;
            split_ratio = 0.5;
            borderless_monocle = true;
            gapless_monocle = false;
            automatic_scheme = "longest_side";
            pointer_follows_focus = true;
            top_padding = 44;
            presel_feedback_color = "#${colors.white}";
            focused_border_color = "#${colors.blue}";
            normal_border_color = "#${colors.black}";
            active_border_color = "#${colors.l_magenta}";
            urgent_border_color = "#${colors.red}";
        };
        rules = {

            "mplayer2".state = "floating";
            "Kupfer.py".focus = true;
            "Screenkey".manage = false;
            "Xfce4-panel" = {
                manage = false;
                border = false;
                layer = "above";
            };
            "Gsimplecal".sticky = true;
            "Conky".manage = false;
        };
        extraConfig = ''
            notify-send "bspwm" "Configuration loaded";
        '';
    };

    services.sxhkd = {
        enable = true;
        keybindings = {
            "mod3 + q" = "bspc node -c";
            "mod3 + w" = "librewolf";
            "mod3 + e" = "thunar";
            "mod3 + r" = "pkill -x sxhkd; sleep 1; sxhkd &";
            "mod3 + t" = "ghostty";
            "mod3 + a" = "rofi -show window";
            "mod3 + s" = "rofi -show drun";
            "mod3 + d" = "rofi -modi 'clipboard:greenclip print' -show clipboard -run-command '{cmd}'";
            "mod3 + l" = "dm-tool lock";
            "mod3 + {z,x,c}" = "xdotool click {1,3,2}";
            "mod3 + comma" = "pkill picom; sleep 1; picom -b";
            "mod3 + period" = "pkill polybar; sleep 1; polybar top &";
            "mod3 + {Left,Down,Up,Right}" = "xdotool mousemove_relative {-- -40 0, 0 40, 0 -40, 40 0}";
            "mod3 + ctrl + {Left,Down,Up,Right}" = "xdotool mousemove_relative {-- -5 0, 0 5, 0 -5, 5 0}";
            "mod3 + shift + {Up,Down,Left,Right}" = "xdotool click {4,5,6,7}";
            "mod3 + shift + {z,x,c}" = "xdotool mousedown {1,3,2}";
            "mod3 + ctrl + {z,x,c}" = "xdotool mouseup {1,3,2}";
            "mod3 + alt + q" = "bspc node -k";
            "mod3 + super + {q,r}" = "bspc {quit,wm -r}";
            "mod3 + super + w" = "ghostty --command='sudo pkill kmscon'";
            "Print" = "xfce4-screenshooter";
            "super + m" = "bspc desktop -l next";
            # send the newest marked node to the newest preselected node
            "super + y" = "bspc node newest.marked.local -n newest.!automatic.local";
            # swap the current node and the biggest window
            "super + g" = "bspc node -s biggest.window";
            "super + {t,shift + t,s,f}" = "bspc node -t {tiled,pseudo_tiled,floating,fullscreen}";
            "super + ctrl + {m,x,y,z}" = "bspc node -g {marked,locked,sticky,private}";
            "super + {_,shift + }{h,j,k,l}" = "bspc node -{f,s} {west,south,north,east}";
            # focus the node for the given path jump
            "super + {p,b,comma,period}" = "bspc node -f @{parent,brother,first,second}";
            # focus the next/previous window in the current desktop
            "super + {_,shift + }c" = "bspc node -f {next,prev}.local.!hidden.window";
            "super + bracket{left,right}" = "bspc desktop -f {prev,next}.local";
            # focus the last node/desktop
            "super + {grave,Tab}" = "bspc {node,desktop} -f last";
            # focus the older or newer node in the focus history
            "super + {o,i}" = "bspc wm -h off; bspc node {older,newer} -f; bspc wm -h on";
            # focus or send to the given desktop
            "super + {_,shift + }{1-9,0,minus,equal}" = "bspc {desktop -f,node -d} '^{1-9,10,11,12}'";
            "super + ctrl + {h,j,k,l}" = "bspc node -p {west,south,north,east}";
            "super + ctrl + {1-9}" = "bspc node -o 0.{1-9}";
            "super + ctrl + space" = "bspc node -p cancel";
            # cancel the preselection for the focused desktop
            "super + ctrl + shift + space" = "bspc query -N -d | xargs -I id -n 1 bspc node id -p cancel";
            "super + alt + {h,j,k,l}" = "bspc node -z {left -20 0,bottom 0 20,top 0 -20,right 20 0}";
            "super + alt + shift + {h,j,k,l}" = "bspc node -z {right -20 0,top 0 20,bottom 0 -20,left 20 0}";
            "super + {Left,Down,Up,Right}" = "bspc node -v {-20 0,0 20,0 -20,20 0}";
        };
    };
}
