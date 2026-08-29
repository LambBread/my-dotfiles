{ config, pkgs, ... }:
let
    colors = import ../../modules/colors.nix;
    personal = import ../../personal.nix;
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
