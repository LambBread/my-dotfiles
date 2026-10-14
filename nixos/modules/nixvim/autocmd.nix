{
    colors,
    pkgs,
    config,
    ...
}:
{

    programs.nixvim.autoCmd = [
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
                "*.script"
            ];
            command = "set filetype=javascript";
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
                "*.plymouth"
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
}
