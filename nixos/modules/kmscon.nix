{
    colors,
    pkgs,
    config,
    ...
}:
{
    services.kmscon = {
        enable = true;
        hwRender = true;
        # config = {
        #     hwaccel = true;
        #     font-name = "MonaspiceAr Nerd Font Mono";
        #     font-size = 14;
        #     palette = "custom";
        #     palette-background = "65,40,83";
        #     palette-foreground = "236,227,213";

        #     palette-black = "65,40,83";
        #     palette-red = "240,133,51";
        #     palette-green = "101,146,38";
        #     palette-yellow = "174,172,30";
        #     palette-blue = "36,91,151";
        #     palette-magenta = "151,104,182";
        #     palette-cyan = "3,173,145";
        #     palette-white = "207,183,147";

        #     palette-light-black = "114,100,124";
        #     palette-light-red = "208,114,113";
        #     palette-light-green = "159,211,86";
        #     palette-light-yellow = "224,222,75";
        #     palette-light-blue = "107,151,219";
        #     palette-light-magenta = "188,158,208";
        #     palette-light-cyan = "54,252,219";
        #     palette-light-white = "236,227,213";
        # }
        extraOptions = "--term xterm-256color --seats seat0";
        extraConfig = ''
            font-name=${colors.font}
            font-size=14
            font-dpi=100

            palette=custom

            palette-background=${colors.hexToRgbStr "#${colors.black}" ","}
            palette-foreground=${colors.hexToRgbStr "#${colors.l_white}" ","}

            palette-black=${colors.hexToRgbStr "#${colors.black}" ","}
            palette-red=${colors.hexToRgbStr "#${colors.red}" ","}
            palette-green=${colors.hexToRgbStr "#${colors.green}" ","}
            palette-yellow=${colors.hexToRgbStr "#${colors.yellow}" ","}
            palette-blue=${colors.hexToRgbStr "#${colors.blue}" ","}
            palette-magenta=${colors.hexToRgbStr "#${colors.magenta}" ","}
            palette-cyan=${colors.hexToRgbStr "#${colors.cyan}" ","}
            palette-white=${colors.hexToRgbStr "#${colors.white}" ","}

            palette-light-black=${colors.hexToRgbStr "#${colors.l_black}" ","}
            palette-light-red=${colors.hexToRgbStr "#${colors.l_red}" ","}
            palette-light-green=${colors.hexToRgbStr "#${colors.l_green}" ","}
            palette-light-yellow=${colors.hexToRgbStr "#${colors.l_yellow}" ","}
            palette-light-blue=${colors.hexToRgbStr "#${colors.l_blue}" ","}
            palette-light-magenta=${colors.hexToRgbStr "#${colors.l_magenta}" ","}
            palette-light-cyan=${colors.hexToRgbStr "#${colors.l_cyan}" ","}
            palette-light-white=${colors.hexToRgbStr "#${colors.l_white}" ","}
        '';
    };

    systemd.services."kmscon@tty7".enable = false;
}
