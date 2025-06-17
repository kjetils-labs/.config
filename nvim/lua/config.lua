vim.g.go_addtags_transform = 'camelcase'

vim.opt.guicursor = ""

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.incsearch = true
vim.opt.scrolloff = 8

---@diagnostic disable-next-line: missing-fields
vim.opt.clipboard = {
    name = 'xsel',
    copy = {
        ['+'] = 'xsel --clipboard --input',
        ['*'] = 'xsel --primary --input',
    },
    paste = {
        ['+'] = 'xsel --clipboard --output',
        ['*'] = 'xsel --primary --output',
    },
    cache_enabled = 0,
}

-- Disables the inline error/warning text
vim.diagnostic.config({
    virutal_text = false,
})

vim.o.updatetime = 250
