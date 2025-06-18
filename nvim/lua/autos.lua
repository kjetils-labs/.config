-- Autoformats on save
vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("lsp", { clear = true }),
    callback = function(args)
        -- 2
        vim.api.nvim_create_autocmd("BufWritePre", {
            -- 3
            buffer = args.buf,
            callback = function()
                -- 4 + 5
                vim.lsp.buf.format { async = false, id = args.data.client_id }
            end,
        })
    end
})


-- Opens neotree automatically on launch when entering vim
vim.api.nvim_create_augroup("neotree", {})
vim.api.nvim_create_autocmd("VimEnter", {
    desc = "Open Neotree automatically",
    group = "neotree",
    callback = function()
        local bufname = vim.fn.expand('%')
        if vim.fn.isdirectory(bufname) == 1 then -- and not vim.fn.exists "s:std_in" then
            vim.cmd("Neotree toggle")
        end
    end
})
