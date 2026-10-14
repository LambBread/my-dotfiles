{
    pkgs,
    config,
    colors,
    ...
}:
{

    imports = [
        ./highlight.nix
        ./autocmd.nix
        ./lines.nix
    ];

    programs.nixvim = {
        enable = true;
        nixpkgs.pkgs = pkgs;
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
        globals = {
            mapleader = ",";
            maplocalleader = ",";
            load_doxygen_syntax = 1;
        };

        plugins = {
            emmet.enable = true;
            visual-multi.enable = true;
            friendly-snippets.enable = true;
            nui.enable = true;
            web-devicons.enable = true;
            nvim-autopairs.enable = true;
            todo-comments.enable = true;
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
                    yuck
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
