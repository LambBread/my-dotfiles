vim.g.mapleader = ","
vim.g.maplocalleader = ","
vim.keymap.set("n", "<leader>h", ":bp<CR>", { silent = true })
vim.keymap.set("n", "<leader>l", ":bn<CR>", { silent = true })
vim.keymap.set("n", "<leader>j", "<C-W>w", { silent = true })
vim.keymap.set("n", "<leader>x", ":bd<CR>", { silent = true })
vim.keymap.set("n", "<F2>", ":Neotree toggle<CR>", { silent = true })
vim.keymap.set("n", "<C-S>", ":w<CR>", { silent = true })

