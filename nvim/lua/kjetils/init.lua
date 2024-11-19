require("kjetils.remap")
require("kjetils.set")
require("kjetils.config")
require("kjetils.packer")

vim.api.nvim_create_augroup("neotree",{})
vim.api.nvim_create_autocmd("VimEnter", {
    desc = "Open Neotree automatically",
    group = "neotree",
    callback = function()
        local bufname = vim.fn.expand('%')
        if vim.fn.isdirectory(bufname) == 1 then -- and not vim.fn.exists "s:std_in" then
            vim.cmd("Neotree toggle")
        end
    end,
})

