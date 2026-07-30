vim.api.nvim_create_autocmd("FileType", {
    pattern = "xpm",
    command = "setlocal syntax=OFF"
})

vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
    pattern = "conky.conf",
    command = "set filetype=lua"
})

vim.cmd("syntax enable")
vim.g.load_doxygen_syntax = 1
vim.api.nvim_create_autocmd("FileType", {
    pattern = {"c", "cpp"},
    command = "setlocal filetype=cpp.doxygen"
})

vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
        if vim.fn.argc() == 0 then
            vim.cmd("Neotree toggle")
        end
    end,
})

-- turn numbers on only for normal file buffers
vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
  callback = function(args)
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
  end,
})
