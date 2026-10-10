{
    colors,
    pkgs,
    config,
    ...
}:
{
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
