{
    config,
    lib,
    pkgs,
    ...
}:
let
    colors = import ../../modules/colors.nix { inherit pkgs; };
    personal = import ../../personal.nix;
    desktop = {
        minimum_height = "1036";
        width = "460";
        text = builtins.readFile ./conky/conky.txt;
    };
    laptop = {
        minimum_height = "724";
        width = "400";
        text = builtins.readFile ./conky/conky_laptop.txt;
    };

    selectedConfig = if personal.DESK_NAME == "laptop" then laptop else desktop;
in
{
    services.conky = {
        enable = true;
        extraConfig = ''
            conky.config = {
                alignment = 'top_left',
                gap_x = 0,
                gap_y = 44,
                minimum_height = ${selectedConfig.minimum_height},
                minimum_width = ${selectedConfig.width},
                maximum_width = ${selectedConfig.width},
                background = false,       
                border_width = 1,
                own_window = true,
                own_window_class = 'Conky',
                own_window_type = 'normal',
                font = '${colors.font}:size=11',
                font1 = '${colors.font}:size=11',
                color1 = '#${colors.white}',                        -- accent
                -- color2 = '#f6bb8d',                        -- shade of col3
                color2 = '#${colors.red}',
                color3 = '#${colors.l_magenta}',
                own_window_transparent = false,            -- transparency
                own_window_argb_visual = true,             -- transparency
                own_window_argb_value = 85,               -- transparency [0 -255]
                own_window_hints = 'undecorated,sticky,below,skip_taskbar,skip_pager',
                -- own_window_colour = '#121214',             -- bg color [comment to full transparency]
                own_window_colour = '#${colors.blue}',
                default_color = 'white',                   -- default colors
                default_outline_color = 'white',           -- default colors
                default_shade_color = 'white',             -- default colors
                double_buffer = true,                      -- removes flickering
                draw_borders = false,                      -- borders (window)
                draw_graph_borders = true,                 -- borders (graphs)
                draw_outline = false,                      -- border (text)
                draw_shades = false,                       -- shades
                extra_newline = false,                     -- extra newline at the end when writing to stdout
                -- other
                update_interval = 0.5,
                cpu_avg_samples = 4,
                net_avg_samples = 4,
                no_buffers = true,
                out_to_console = false,
                out_to_ncurses = false,
                out_to_stderr = false,
                out_to_x = true,
                show_graph_range = false,
                show_graph_scale = false,
                stippled_borders = 0,
                uppercase = false,
                use_spacer = 'none',
                use_xft = true
            }

            conky.text = [[
                ${selectedConfig.text}
            ]]
        '';
    };
}
