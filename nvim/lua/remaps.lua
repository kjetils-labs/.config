local function map(mode, shortcut, command)
    vim.keymap.set(mode, shortcut, command, { noremap = true, silent = true })
end

local function nmap(shortcut, command)
    map("n", shortcut, command)
end

-- local function imap(shortcut, command)
--     map("i", shortcut, command)
-- end

-- Unmap space to clear any existing functionality
vim.keymap.set('n', '<Space>', '<Nop>', { noremap = true, silent = true })
vim.keymap.set('v', '<Space>', '<Nop>', { noremap = true, silent = true })
vim.keymap.set('x', '<Space>', '<Nop>', { noremap = true, silent = true })
vim.keymap.set('o', '<Space>', '<Nop>', { noremap = true, silent = true })

-- Sets the mapleader to space bar
vim.g.mapleader = " "




nmap("<Leader>e", ":lua Toggle_diagnostics_autocmd()<CR>")

nmap("<Up>", "<NOP>")
nmap("<Down>", "<NOP>")
nmap("<Left>", "<NOP>")
nmap("<Right>", "<NOP>")
