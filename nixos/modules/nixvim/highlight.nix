{
    colors,
    pkgs,
    config,
    ...
}:
{
    programs.nixvim.colorscheme = "vim";
    programs.nixvim.highlightOverride = {
        "Normal".fg = "#${colors.l_white}";
        "Comment".fg = "#${colors.magenta}";
        "Comment".italic = true;

        "String".fg = "#${colors.white}";
        "Constant".fg = "#${colors.l_cyan}";
        "Character".fg = "#${colors.white}";
        "Number".fg = "#${colors.l_cyan}";
        "Boolean".fg = "#${colors.l_cyan}";
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
        "NeoTreeFileStats".fg = "#${colors.l_black}";
        "NeoTreeFileStats".italic = true;
        "NeoTreeFileStatsHeader".fg = "#${colors.l_black}";
        "NeoTreeFileStatsHeader".italic = true;
        "NeoTreeFileStatsHeader".bold = true;
        "Changed".fg = "#${colors.l_yellow}";
        "Changed".italic = true;
        "Removed".fg = "#${colors.l_red}";
        "Removed".italic = true;
        "Added".fg = "#${colors.l_green}";
        "DiffChange".bg = "#${colors.magenta}";
        "TodoBgTODO" = {
            bg = "#${colors.l_cyan}";
            fg = "#${colors.black_alt}";
            bold = true;
            italic = true;
        };
        "TodoBgFIX" = {
            bg = "#${colors.red}";
            fg = "#${colors.black_alt}";
            bold = true;
            italic = true;
        };
        "TodoBgHACK" = {
            bg = "#${colors.l_red}";
            fg = "#${colors.black_alt}";
            bold = true;
            italic = true;
        };
        "TodoBgWARN" = {
            bg = "#${colors.l_red}";
            fg = "#${colors.black_alt}";
            bold = true;
            italic = true;
        };
        "TodoBgTEST" = {
            bg = "#${colors.l_blue}";
            fg = "#${colors.black_alt}";
            bold = true;
            italic = true;
        };

        "TodoBgNOTE" = {
            bg = "#${colors.l_white}";
            fg = "#${colors.black_alt}";
            bold = true;
            italic = true;
        };
        "TodoBgPERF" = {
            bg = "#${colors.l_green}";
            fg = "#${colors.black_alt}";
            bold = true;
            italic = true;
        };
        "TodoSignTODO".fg = "#${colors.l_cyan}";
        "TodoSignFIX".fg = "#${colors.red}";
        "TodoSignHACK".fg = "#${colors.l_red}";
        "TodoSignWARN".fg = "#${colors.l_red}";
        "TodoSignTEST".fg = "#${colors.l_blue}";
        "TodoSignNOTE".fg = "#${colors.l_white}";
        "TodoSignPERF".fg = "#${colors.l_green}";
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
        "Title".fg = "#${colors.l_cyan}";
        "Title".bold = true;
    };
}
