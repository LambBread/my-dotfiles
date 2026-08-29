vim.g.mapleader = ","
vim.g.maplocalleader = ","
vim.keymap.set("n", "<leader>h", ":bp<CR>", { silent = true })
vim.keymap.set("n", "<leader>l", ":bn<CR>", { silent = true })
vim.keymap.set("n", "<leader>j", "<C-W>w", { silent = true })
vim.keymap.set("n", "<leader>x", ":bd<CR>", { silent = true })
vim.keymap.set("n", "<F2>", ":Neotree toggle<CR>", { silent = true })
vim.keymap.set("n", "<C-S>", ":w<CR>", { silent = true })
vim.keymap.set("n", "<Find>", "0")
vim.keymap.set("n", "<Select>", "$")
vim.keymap.set("i", "<C-S>", "<C-o>:w<CR>")
vim.keymap.set("i", "<F2>", "<C-o>:Neotree toggle<CR>")
vim.keymap.set("i", "<Find>", "<C-o>0")
vim.keymap.set("i", "<Select>", "<C-o>$")

