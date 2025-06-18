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

vim.g.go_addtags_transform = 'camelcase' -- Makes the tags camelcase instead of snake case
vim.g.go_doc_popup_window = 1            -- Makes to Godoc use a popup window instead of a new pane
vim.g.go_info_popup_window = 1           -- Popups for info like function signatures
vim.g.go_highlight_auto_align = 1        -- highlight auto alignment
vim.g.go_auto_imports = 1                -- Automatically add imports as you code
