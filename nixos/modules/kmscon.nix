{
    colors,
    pkgs,
    config,
    ...
}:
{
    services.kmscon = {
        enable = true;
        config = {
            hwaccel = true;
            font-size = 14;
            font-name = colors.font;
            palette = "custom";
            palette-background = colors.hexToRgbStr "#${colors.black}" ",";
            palette-foreground = colors.hexToRgbStr "#${colors.l_white}" ",";

            palette-black = colors.hexToRgbStr "#${colors.black}" ",";
            palette-red = colors.hexToRgbStr "#${colors.red}" ",";
            palette-green = colors.hexToRgbStr "#${colors.green}" ",";
            palette-yellow = colors.hexToRgbStr "#${colors.yellow}" ",";
            palette-blue = colors.hexToRgbStr "#${colors.blue}" ",";
            palette-magenta = colors.hexToRgbStr "#${colors.magenta}" ",";
            palette-cyan = colors.hexToRgbStr "#${colors.cyan}" ",";
            palette-white = colors.hexToRgbStr "#${colors.white}" ",";

            palette-light-black = colors.hexToRgbStr "#${colors.l_black}" ",";
            palette-light-red = colors.hexToRgbStr "#${colors.l_red}" ",";
            palette-light-green = colors.hexToRgbStr "#${colors.l_green}" ",";
            palette-light-yellow = colors.hexToRgbStr "#${colors.l_yellow}" ",";
            palette-light-blue = colors.hexToRgbStr "#${colors.l_blue}" ",";
            palette-light-magenta = colors.hexToRgbStr "#${colors.l_magenta}" ",";
            palette-light-cyan = colors.hexToRgbStr "#${colors.l_cyan}" ",";
            palette-light-white = colors.hexToRgbStr "#${colors.l_white}" ",";

        };
        extraOptions = "--term xterm-256color --seats seat0";
        #extraConfig = ''
        #    font-name=${colors.font}
        #    font-size=14
        #    font-dpi=100

        #    palette=custom

        #    palette-background=${colors.hexToRgbStr "#${colors.black}" ","}
        #    palette-foreground=${colors.hexToRgbStr "#${colors.l_white}" ","}

        #    palette-black=${colors.hexToRgbStr "#${colors.black}" ","}
        #    palette-red=${colors.hexToRgbStr "#${colors.red}" ","}
        #    palette-green=${colors.hexToRgbStr "#${colors.green}" ","}
        #    palette-yellow=${colors.hexToRgbStr "#${colors.yellow}" ","}
        #    palette-blue=${colors.hexToRgbStr "#${colors.blue}" ","}
        #    palette-magenta=${colors.hexToRgbStr "#${colors.magenta}" ","}
        #    palette-cyan=${colors.hexToRgbStr "#${colors.cyan}" ","}
        #    palette-white=${colors.hexToRgbStr "#${colors.white}" ","}

        #    palette-light-black=${colors.hexToRgbStr "#${colors.l_black}" ","}
        #    palette-light-red=${colors.hexToRgbStr "#${colors.l_red}" ","}
        #    palette-light-green=${colors.hexToRgbStr "#${colors.l_green}" ","}
        #    palette-light-yellow=${colors.hexToRgbStr "#${colors.l_yellow}" ","}
        #    palette-light-blue=${colors.hexToRgbStr "#${colors.l_blue}" ","}
        #    palette-light-magenta=${colors.hexToRgbStr "#${colors.l_magenta}" ","}
        #    palette-light-cyan=${colors.hexToRgbStr "#${colors.l_cyan}" ","}
        #    palette-light-white=${colors.hexToRgbStr "#${colors.l_white}" ","}
        #'';
    };

    systemd.services."kmscon@tty7".enable = false;
}
