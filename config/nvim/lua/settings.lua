vim.opt.termguicolors = true
vim.opt.encoding = "UTF-8"
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.number = false
vim.opt.relativenumber = false
vim.opt.cursorline = true
vim.cmd.colorscheme("vim")

local colors =
{
    color_0 = "#245b97",
    color_1 = "#bc9ed0",
    color_2 = "#f08533",
    color_3 = "#cfb793",
    color_4 = "#9FD356",
    light_col0 = "#6ba1db",
    dark_col1 = "#9768B6",
    verydark_col1 = "#412853",
    color_red = "#d07271",
    color_black = "#0c1315",
    color_white = "#ece3d5",
    color_yellow = "#e0de4b"
}
vim.api.nvim_set_hl(0, "Normal", { fg = colors.color_white })
vim.api.nvim_set_hl(0, "Comment", { fg = colors.dark_col1, italic = true })
vim.api.nvim_set_hl(0, "String", { fg = colors.color_3 })

vim.api.nvim_set_hl(0, "Constant", { fg = colors.color_2 })
vim.api.nvim_set_hl(0, "Character", { fg = colors.color_3 })
vim.api.nvim_set_hl(0, "Number", { fg = colors.color_2 })
vim.api.nvim_set_hl(0, "Boolean", { fg = colors.color_2, bold = true })

vim.api.nvim_set_hl(0, "Special", { fg = colors.color_red })
vim.api.nvim_set_hl(0, "PreProc", { fg = colors.color_1 })
vim.api.nvim_set_hl(0, "Statement", { fg = colors.color_1, bold = true })
vim.api.nvim_set_hl(0, "Identifier", { fg = colors.light_col0 })
vim.api.nvim_set_hl(0, "Function", { fg = colors.color_4 })
vim.api.nvim_set_hl(0, "Type", { fg = colors.color_4, bold = true })

vim.api.nvim_set_hl(0, "VertSplit", {fg = colors.color_0})
vim.api.nvim_set_hl(0, "Directory", { fg = colors.color_1 })
vim.api.nvim_set_hl(0, "Pmenu", { bg = colors.verydark_col1, fg = colors.color_white }) 
vim.api.nvim_set_hl(0, "PmenuSel", { bg = colors.dark_col1, fg = colors.color_white })
vim.api.nvim_set_hl(0, "DevIconC", { fg = colors.color_1 })
vim.api.nvim_set_hl(0, "DevIconH", { fg = colors.dark_col1 })
vim.api.nvim_set_hl(0, "NeoTreeDotfile", { fg = colors.dark_col1, italic = true })

vim.api.nvim_set_hl(0, "Changed", {fg = colors.color_yellow, italic = true})
vim.api.nvim_set_hl(0, "Removed", {fg = colors.color_red, italic = true})
vim.api.nvim_set_hl(0, "Todo", { bg = colors.color_2, fg = colors.color_black, bold = true, italic = true })
vim.api.nvim_set_hl(0, "Search", {bg = colors.color_4, fg = colors.color_black})
vim.api.nvim_set_hl(0, "CursorLine", { bg = colors.verydark_col1 })
vim.api.nvim_set_hl(0, "LineNr", { fg = colors.dark_col1 })
vim.api.nvim_set_hl(0, "CursorLineNr", { fg = colors.color_4, bold = true, italic = true})
vim.api.nvim_set_hl(0, "NonText", { fg = colors.dark_col1 })
vim.api.nvim_set_hl(0, "Visual", { bg = colors.verydark_col1, fg = colors.color_white })
vim.api.nvim_set_hl(0, "WarningMsg", { fg = colors.color_red, italic = true })
vim.api.nvim_set_hl(0, "ErrorMsg", {bg = colors.color_2, fg = colors.color_white, italic = true, bold = true})

return colors
-- this is a comment
