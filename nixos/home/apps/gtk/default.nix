{
    config,
    pkgs,
    colors,
    ...
}:
{
    imports = [
        ./thunar.nix
        ./xdg.nix
    ];
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
        @define-color custom-col-white #${colors.white};
        @define-color custom-col-l-black #${colors.l_black};
        @define-color custom-col-l-magenta #${colors.l_magenta};
        @define-color custom-col-l-white #${colors.l_white};
        @define-color thunar-colour shade(@custom-col-blue, 0.85);
        @define-color dark-thunar-colour shade(@thunar-colour, 0.85);
        @define-color black-thunar-colour shade(@thunar-colour, 0.6);
        @define-color theme_selected_bg_color @custom-col-magenta;
        @define-color theme_selected_fg_color @custom-col-l-white;
        @define-color theme_unfocused_selected_bg_color @custom-col-magenta;
        @define-color theme_base_color @custom-col-black;
        @define-color theme_text_color @custom-col-l-white;
        @define-color theme_fg_color @custom-col-l-white;
        @define-color theme_bg_color @custom-col-black;
    '';
    xdg.configFile."gtk-3.0/gtk.css".text =
        builtins.replaceStrings [ "MonaspiceAr Nerd Font Mono" ] [ "${colors.font}" ]
            (builtins.readFile ./gtk.css);
    #xdg.configFile."gtk-3.0/thunar.css".source = ./gtk-3.0/thunar.css;
}
