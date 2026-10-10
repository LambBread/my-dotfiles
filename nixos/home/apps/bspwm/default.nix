{
    config,
    pkgs,
    colors,
    personal,
    ...
}:
let
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
            xset +dpms
            xset dpms 300 300 300
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
            "${builtins.elemAt personal.MONITORS 0}" = [
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
            xset +dpms
            xset dpms 300 300 300
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
    imports = [
        ./dunst.nix
        ./picom.nix
        ./polybar.nix
        ./rofi.nix
        ./sxhkd.nix
    ];
    xsession.windowManager.bspwm = {
        enable = true;
        inherit monitors;
        inherit extraConfigEarly;
        settings = {
            border_width = colors.border_width;
            window_gap = colors.window_gap;
            split_ratio = 0.5;
            borderless_monocle = true;
            gapless_monocle = false;
            automatic_scheme = "longest_side";
            pointer_follows_focus = true;
            top_padding = colors.bar_width + colors.window_gap;
            presel_feedback_color = "#${colors.white}";
            focused_border_color = "#${colors.l_green}";
            normal_border_color = "#${colors.l_black}";
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

}
