{ config, pkgs, ... }:
let
    colors = import ../../modules/colors.nix { inherit pkgs; };
in
{
    xdg.configFile."ghostty/shaders" = {
        source = ./ghostty/shaders;
        recursive = true;
    };
    programs.ghostty = {
        enable = true;
        themes = {
            my-custom = {
                background = "${colors.black}";
                foreground = "${colors.l_white}";
                cursor-color = "${colors.l_magenta}";
                selection-background = "${colors.black}";
                selection-foreground = "${colors.l_white}";
                palette = [
                    "0=${colors.black}"
                    "1=${colors.red}"
                    "2=${colors.green}"
                    "3=${colors.yellow}"
                    "4=${colors.blue}"
                    "5=${colors.magenta}"
                    "6=${colors.cyan}"
                    "7=${colors.white}"
                    "8=${colors.l_black}"
                    "9=${colors.l_red}"
                    "10=${colors.l_green}"
                    "11=${colors.l_yellow}"
                    "12=${colors.l_blue}"
                    "13=${colors.l_magenta}"
                    "14=${colors.l_cyan}"
                    "15=${colors.l_white}"
                ];
            };
        };
        settings = {
            font-family = "${colors.font}";
            font-family-bold = "${colors.font}";
            font-family-italic = "${colors.font}";
            font-family-bold-italic = "${colors.font}";
            font-size = 12;
            working-directory = "home";
            window-inherit-working-directory = false;
            background-opacity = 0.67;
            window-decoration = "server";
            window-padding-x = 15;
            window-padding-y = 15;

            custom-shader = [
                "shaders/cursor_warp.glsl"
                "shaders/bloom.glsl"
            ];
            theme = "my-custom";
        };
    };
}
