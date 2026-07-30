vim.opt.termguicolors = true
vim.opt.encoding = "UTF-8"
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.number = false
vim.opt.relativenumber = false
vim.cmd.colorscheme("vim")

local colors =
{
    color_0 = "#245b97",
    color_1 = "#bc9ed0",
    color_2 = "#f08533",
    color_3 = "#cfb793",
    color_4 = "#9FD356",
    dark_col0 = "#5b97d7",
    dark_col1 = "#9768B6",
    color_red = "#d07271",
    color_black = "#0c1315",
    color_white = "#ece3d5"
}
vim.api.nvim_set_hl(0, "Comment", {fg = colors.dark_col1, italic = true})
vim.api.nvim_set_hl(0, "String", {fg = colors.color_3})
vim.api.nvim_set_hl(0, "Special", {fg = colors.color_red})
vim.api.nvim_set_hl(0, "PreProc", {fg = colors.color_1})
vim.api.nvim_set_hl(0, "Statement", {fg = colors.color_2, bold = true})
vim.api.nvim_set_hl(0, "Identifier", {fg = colors.dark_col0})
vim.api.nvim_set_hl(0, "Directory", {fg = colors.dark_col0})
vim.api.nvim_set_hl(0, "Type", {fg = colors.color_4, bold = true})
vim.api.nvim_set_hl(0, "Constant", {fg = colors.color_2})
vim.api.nvim_set_hl(0, "Changed", {fg = "#ffff00"})
vim.api.nvim_set_hl(0, "Pmenu", {bg = colors.color_1})
vim.api.nvim_set_hl(0, "WarningMsg", {fg = colors.color_red, italic = true})
vim.api.nvim_set_hl(0, "LineNr", {fg = colors.color_4, bold = true, italic = true})
vim.api.nvim_set_hl(0, "NonText", {fg = colors.dark_col1})
vim.api.nvim_set_hl(0, "CursorLine", {fg = colors.color_1, bold = true})
vim.api.nvim_set_hl(0, "Visual", { bg = colors.color_3, fg = colors.color_black})

vim.api.nvim_set_hl(0, "DevIconC", {fg = colors.color_1})
vim.api.nvim_set_hl(0, "DevIconH", {fg = colors.dark_col1})
vim.api.nvim_set_hl(0, "NeoTreeDotfile", {fg = colors.dark_col1, italic = true})

return colors
-- this is a comment
