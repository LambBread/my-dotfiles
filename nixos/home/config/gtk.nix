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

        @define-color custom-col-1 #${colors.blue};
        @define-color custom-col-3 #${colors.l_magenta};
        @define-color custom-col-black #${colors.black};
        @define-color text-colour #${colors.l_white};
        @define-color tasklist-colour shade(@custom-col-1, 0.85);
        @define-color button-select-colour shade(@custom-col-1, 0.55);
        @define-color tasklist-colour-shaded-blue shade(@tasklist-colour, 0.85);
        @define-color tasklist-colour-col3 #${colors.magenta};
        @define-color button-select-colour-shaded shade(@tasklist-colour-col3, 0.55);
        @define-color theme_selected_bg_color @tasklist-colour-col3;
        @define-color theme_unfocused_selected_bg_color @tasklist-colour-col3;
        @define-color theme_text_color @text-colour;
    '';
    xdg.configFile."gtk-3.0/gtk.css".text = ''
        @import 'custom_colors.css';
        @import 'thunar.css';

        menu, .menu
        {
            background-color: @custom-col-black;
            color: @text-colour;
            padding: 4px;
        }

        menuitem, .menuitem
        {
            padding: 8px 4px;
            transition: all 200ms ease;
        }

        menuitem:hover, .menuitem:hover
        {
            background-color: @tasklist-colour-col3;
        }


        calendar, GtkCalendar
        {
            background: @custom-col-1;
            color: @text-colour;
            font-family: "${colors.font}", monospace;
        }

        calendar:selected, GtkCalendar:selected
        {
            background: @custom-col-3;
        }
    '';
    xdg.configFile."gtk-3.0/thunar.css".source = ./gtk-3.0/thunar.css;
}
