{ config, pkgs, ... }:
let
    colors = import ../../modules/colors.nix { inherit pkgs; };
in
{
    gtk = {
        enable = true;
        font = {
            name = "${colors.font}";
            size = 11;
        };
        colorScheme = "dark";
        theme.name = "${colors.theme}";
        iconTheme.name = "${colors.icon_theme}";
        cursorTheme.name = "${colors.cursor_theme}";
    };
    xdg.configFile."gtk-3.0/custom_colors.css".text = ''

        @define-color custom-col-black #${colors.black};
        @define-color custom-col-blue #${colors.blue};
        @define-color custom-col-magenta #${colors.magenta};
        @define-color custom-col-l-black #${colors.l_black};
        @define-color custom-col-l-magenta #${colors.l_magenta};
        @define-color custom-col-l-white #${colors.l_white};
        @define-color theme_selected_bg_color @custom-col-magenta;
        @define-color theme_unfocused_selected_bg_color @custom-col-magenta;
        @define-color theme_text_color @custom-col-l-white;
    '';
    xdg.configFile."gtk-3.0/gtk.css".text = ''
        @import 'custom_colors.css';
        @import 'thunar.css';

        menu, .menu
        {
            background-color: @custom-col-black;
            color: @custom-col-l-white;
            padding: 4px;
        }

        menuitem, .menuitem
        {
            padding: 8px 4px;
            transition: all 200ms ease;
        }

        menuitem:hover, .menuitem:hover
        {
            background-color: @custom-col-magenta;
        }


        calendar, GtkCalendar
        {
            background: @custom-col-blue;
            color: @custom-col-l-white;
            font-family: "${colors.font}", monospace;
        }

        calendar:selected, GtkCalendar:selected
        {
            background: @custom-col-magenta;
        }
    '';
    xdg.configFile."gtk-3.0/thunar.css".source = ./gtk-3.0/thunar.css;
}
