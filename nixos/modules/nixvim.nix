{ pkgs, config, ... }:
let
    colors = import ./colors.nix { inherit pkgs; };
in
{
    programs.nixvim = {
        enable = true;
        defaultEditor = true;
        opts = {
            termguicolors = true;
            encoding = "UTF-8";
            expandtab = true;
            tabstop = 4;
            shiftwidth = 4;
            number = false;
            relativenumber = false;
            cursorline = true;
        };
        colorscheme = "vim";
        globals = {
            mapleader = ",";
            maplocalleader = ",";
            load_doxygen_syntax = 1;
        };
        extraPlugins = [
            pkgs.vimPlugins.plenary-nvim
        ];
        extraConfigLua = ''
            vim.cmd("syntax enable")
        '';

        highlightOverride = {
            "Normal".fg = "#${colors.l_white}";
            "Comment".fg = "#${colors.magenta}";
            "Comment".italic = true;

            "String".fg = "#${colors.white}";
            "Constant".fg = "#${colors.red}";
            "Character".fg = "#${colors.white}";
            "Number".fg = "#${colors.red}";
            "Boolean".fg = "#${colors.red}";
            "Boolean".bold = true;
            "Special".fg = "#${colors.l_red}";
            "PreProc".fg = "#${colors.l_magenta}";
            "Statement".fg = "#${colors.l_magenta}";
            "Statement".bold = true;
            "Identifier".fg = "#${colors.l_blue}";
            "Function".fg = "#${colors.l_green}";
            "Type".fg = "#${colors.l_green}";
            "Type".bold = true;
            "VertSplit".fg = "#${colors.blue}";
            "Directory".fg = "#${colors.l_magenta}";
            "Pmenu".bg = "#${colors.black}";
            "Pmenu".fg = "#${colors.l_white}";
            "PmenuSel".bg = "#${colors.magenta}";
            "PmenuSel".fg = "#${colors.l_white}";
            "DevIconC".fg = "#${colors.l_magenta}";
            "DevIconH".fg = "#${colors.magenta}";
            "NeoTreeDotfile".fg = "#${colors.magenta}";
            "NeoTreeDotfile".italic = true;
            "Changed".fg = "#${colors.l_yellow}";
            "Changed".italic = true;
            "Removed".fg = "#${colors.l_red}";
            "Removed".italic = true;
            "Todo" = {
                bg = "#${colors.red}";
                fg = "#${colors.black_alt}";
                bold = true;
                italic = true;
            };
            "Search".bg = "#${colors.l_green}";
            "Search".fg = "#${colors.black_alt}";
            "CursorLine".bg = "#${colors.black}";
            "LineNr".fg = "#${colors.magenta}";
            "CursorLineNr" = {
                fg = "#${colors.l_green}";
                bold = true;
                italic = true;
            };
            "NonText".fg = "#${colors.magenta}";
            "Visual".bg = "#${colors.black}";
            "Visual".fg = "#${colors.l_white}";
            "WarningMsg".fg = "#${colors.l_red}";
            "WarningMsg".italic = true;
            "ErrorMsg" = {
                bg = "#${colors.red}";
                fg = "#${colors.l_white}";
                italic = true;
                bold = true;
            };
            "Title".fg = "#${colors.l_black}";
            "Title".bold = true;
        };

        autoCmd = [
            {
                event = [ "FileType" ];
                pattern = "xpm";
                command = "setlocal syntax=OFF";
            }
            {
                event = [
                    "BufRead"
                    "BufNewFile"
                ];
                pattern = [
                    "conky.conf"
                    "conky_laptop.conf"
                ];
                command = "set filetype=lua";
            }
            {
                event = [
                    "BufRead"
                    "BufNewFile"
                ];
                pattern = [ "config" ];
                command = "set filetype=conf";
            }
            {
                event = [
                    "BufRead"
                    "BufNewFile"
                ];
                pattern = [
                    "dunstrc"
                    "redshift.conf"
                ];
                command = "set filetype=dosini";
            }
            {
                event = [ "FileType" ];
                pattern = [
                    "c"
                    "cpp"
                ];
                command = "setlocal filetype=cpp.doxygen";
            }
            #{
            # event = ["FileType"];
            # pattern = ["*"];
            # callback = ''
            #    function()
            #        pcall(vim.treesitter.start)
            #    end
            # '';
            #}
            {
                event = [ "VimEnter" ];
                callback.__raw = ''
                    function()
                        if vim.fn.argc() == 0 then
                            vim.cmd("Neotree toggle")
                        end
                    end
                '';
            }
            {
                event = [
                    "BufReadPost"
                    "BufNewFile"
                ];
                callback.__raw = ''
                    function(args)
                      local bufnr = args.buf
                      local bt = vim.api.nvim_buf_get_option(bufnr, "buftype")
                      local ft = vim.api.nvim_buf_get_option(bufnr, "filetype")

                      -- skip special buffers: terminals, NvimTree, help, etc.
                      local skip = {
                        terminal = true,
                        help = true,
                        qf = true,
                        NvimTree = true,
                        ["neo-tree"] = true,
                      }

                      if bt == "" and not skip[ft] then
                        vim.api.nvim_set_option_value("number", true, { scope = "local", win = 0 })
                        -- vim.api.nvim_set_option_value("relativenumber", true, { scope = "local", win = 0 })
                      else
                        vim.api.nvim_set_option_value("number", false, { scope = "local", win = 0 })
                        vim.api.nvim_set_option_value("relativenumber", false, { scope = "local", win = 0 })
                      end
                    end
                '';
            }
        ];

        plugins = {
            emmet.enable = true;
            visual-multi.enable = true;
            friendly-snippets.enable = true;
            nui.enable = true;
            web-devicons.enable = true;
            blink-cmp = {
                enable = true;
                settings = {
                    keymap.preset = "default";
                    appearance.nerd_font_variant = "mono";
                    sources.default = [
                        "lsp"
                        "path"
                        "snippets"
                        "buffer"
                    ];
                    sources.providers = { };
                };
            };
            snacks = {
                enable = true;
                settings = {
                    image.enabled = true;
                    image.doc = {
                        inline = true;
                        float = true;
                    };
                };
            };
            neo-tree = {
                enable = true;
                settings = {
                    filesystem.filtered_items = {
                        visible = true;
                        hide_gitignored = true;
                        hide_dotfiles = false;
                        hide_hidden = false;
                        hide_by_name = [ ];
                        never_show = [ ".git" ];
                    };
                    use_snacks_image = true;
                };
            };
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
                };
            };
            nvim-autopairs.enable = true;
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
            ccc = {
                enable = true;
                settings.highlighter.auto_enable = true;
                settings.highlighter.lsp = true;
            };
            treesitter = {
                enable = true;
                highlight.enable = true;
                # folding.enable = true;
                grammarPackages = with config.programs.nixvim.plugins.treesitter.package.builtGrammars; [
                    lua
                    python
                    javascript
                    c
                    cpp
                    doxygen
                    markdown
                    cmake
                    css
                    html
                    latex
                    scss
                    svelte
                    tsx
                    typst
                    vue
                    nix
                    regex
                    glsl
                    bash
                ];
            };
        };

        keymaps = [
            {
                mode = "n";
                key = "<leader>h";
                action = ":bp<CR>";
                options.silent = true;
            }
            {
                mode = "n";
                key = "<leader>l";
                action = ":bn<CR>";
                options.silent = true;
            }
            {
                mode = "n";
                key = "<leader>j";
                action = "<C-W>w";
                options.silent = true;
            }
            {
                mode = "n";
                key = "<leader>x";
                action = ":bd<CR>";
                options.silent = true;
            }
            {
                mode = "n";
                key = "<F2>";
                action = ":Neotree toggle<CR>";
                options.silent = true;
            }
            {
                mode = "n";
                key = "<C-S>";
                action = ":w<CR>";
                options.silent = true;
            }
            {
                mode = "n";
                key = "<Find>";
                action = "0";
            }
            {
                mode = "n";
                key = "<Select>";
                action = "$";
            }
            {
                mode = "i";
                key = "<C-S>";
                action = "<C-o>:w<CR>";
            }
            {
                mode = "i";
                key = "<F2>";
                action = "<C-o>:Neotree toggle<CR>";
            }
            {
                mode = "i";
                key = "<Find>";
                action = "<C-o>0";
            }
            {
                mode = "i";
                key = "<Select>";
                action = "<C-o>$";
            }
        ];
    };
}
