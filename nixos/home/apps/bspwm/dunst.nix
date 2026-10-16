{
    colors,
    pkgs,
    config,
    ...
}:
{

    xdg.configFile."rofi/config.rasi".text =
        builtins.replaceStrings
            [
                "412853"
                "9768b6"
                "ece3d5"
                "border-radius: 16px"
                "MonaspiceAr Nerd Font Mono"
                "Rowaita-Lavender-Dark"
            ]
            [
                "${colors.black}"
                "${colors.magenta}"
                "${colors.l_white}"
                "border-radius: ${builtins.toString colors.corner_radius}px"
                "${colors.font}"
                "${colors.icon_theme}"
            ]
            (builtins.readFile ./config.rasi);
    services.dunst = {
        enable = true;
        settings = {
            global = {
                icon_theme = "${colors.icon_theme}";
                enable_recursive_icon_lookup = true;
                background = "#${colors.black}";
                font = "${colors.font} 11";
                frame_width = 0;
                sort = true;
                padding = 6;
                horizontal_padding = 12;
                transparency = 33;
                alignment = "center";
                timeout = 5;
            };
        };
    };
}
