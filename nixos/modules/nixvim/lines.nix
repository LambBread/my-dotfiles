{
    config,
    pkgs,
    colors,
    ...
}:
{
    programs.nixvim.plugins = {
        bufferline = {
            enable = true;
            settings.options.color_icons = true;
            settings.options.themeable = true;
            settings.options.separator_style = "slant";
            settings.highlights = {
                fill.fg = "#${colors.magenta}";
                buffer_visible.fg = "#${colors.magenta}";
                background.fg = "#${colors.magenta}";
                buffer_selected.fg = "#${colors.l_magenta}";
                buffer_selected.bg = "#${colors.black_alt}";
                separator_visible.fg = "#${colors.magenta}";
                separator.fg = "#${colors.magenta}";
                separator_selected.fg = "#${colors.l_magenta}";
                close_button_visible.fg = "#${colors.magenta}";
                close_button.fg = "#${colors.magenta}";
                close_button_selected.fg = "#${colors.l_magenta}";
                trunc_marker.fg = "#${colors.magenta}";
                duplicate.fg = "#${colors.magenta}";
                duplicate.bg = "#${colors.black_alt}";
                duplicate.italic = true;
                duplicate_visible.fg = "#${colors.magenta}";
                duplicate_visible.bg = "#${colors.black_alt}";
                duplicate_visible.italic = true;
                duplicate_selected.fg = "#${colors.l_magenta}";
                duplicate_selected.bg = "#${colors.black_alt}";
                duplicate_selected.italic = true;
                modified.fg = "#${colors.magenta}";
                modified.bg = "#${colors.l_white}";
                modified_visible.fg = "#${colors.magenta}";
                modified_visible.bg = "#${colors.l_white}";
                modified_selected.fg = "#${colors.l_magenta}";
                modified_selected.bg = "#${colors.l_white}";

            };
        };
        lualine = {
            enable = true;
            settings.options = {
                theme = {
                    normal = {
                        a = {
                            fg = "#${colors.black_alt}";
                            bg = "#${colors.magenta}";
                            gui = "bold";
                        };
                        c = {
                            fg = "#${colors.l_white}";
                            bg = "#${colors.black_alt}";
                        };
                    };
                    insert = {
                        a = {
                            fg = "#${colors.black_alt}";
                            bg = "#${colors.white}";
                            gui = "bold";
                        };
                        c = {
                            fg = "#${colors.l_white}";
                            bg = "#${colors.black_alt}";
                        };
                    };
                    visual = {
                        a = {
                            fg = "#${colors.black_alt}";
                            bg = "#${colors.l_red}";
                            gui = "bold";
                        };
                        c = {
                            fg = "#${colors.l_white}";
                            bg = "#${colors.black_alt}";
                        };
                    };
                    replace = {
                        a = {
                            fg = "#${colors.black_alt}";
                            bg = "#${colors.red}";
                            gui = "bold";
                        };
                        c = {
                            fg = "#${colors.l_white}";
                            bg = "#${colors.black_alt}";
                        };
                    };
                    command = {
                        a = {
                            fg = "#${colors.black_alt}";
                            bg = "#${colors.l_blue}";
                            gui = "bold";
                        };
                        c = {
                            fg = "#${colors.l_white}";
                            bg = "#${colors.black_alt}";
                        };
                    };
                    terminal = {
                        a = {
                            fg = "#${colors.black_alt}";
                            bg = "#${colors.l_blue}";
                            gui = "bold";
                        };
                        c = {
                            fg = "#${colors.l_white}";
                            bg = "#${colors.black_alt}";
                        };
                    };
                };
            };
        };
    };
}
