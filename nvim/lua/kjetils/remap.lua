function map(mode, shortcut, command)
    vim.keymap.set(mode, shortcut, command, { noremap = true, silent = true })
end

function nmap(shortcut, command)
    map("n", shortcut, command)
end

function imap(shortcut, command)
    map("i", shortcut, command)
end

-- Unmap space to clear any existing functionality
vim.keymap.set('n', '<Space>', '<Nop>', { noremap = true, silent = true })
vim.keymap.set('v', '<Space>', '<Nop>', { noremap = true, silent = true })
vim.keymap.set('x', '<Space>', '<Nop>', { noremap = true, silent = true })
vim.keymap.set('o', '<Space>', '<Nop>', { noremap = true, silent = true })
-- Sets the mapleader to space bar
vim.g.mapleader = " "


-- Initialize a variable to track the state
local autocmd_enabled = false

-- Function to toggle the autocmd
function Toggle_diagnostics_autocmd()
    if autocmd_enabled then
        -- Clear the autocmd if it is active
        vim.api.nvim_clear_autocmds({ group = "DiagnosticsGroup" })
        autocmd_enabled = false
        print("Diagnostics autocmd disabled")
    else
        -- Define the autocmd group
        local group = vim.api.nvim_create_augroup("DiagnosticsGroup", { clear = true })

        -- Create the autocmd to show diagnostics
        vim.api.nvim_create_autocmd("CursorHold", {
            group = group,
            callback = function()
                local opts = {
                    focusable = false,
                    close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
                    border = "rounded",
                    source = "always",
                    prefix = " ",
                    scope = "cursor",
                }
                vim.diagnostic.open_float(nil, opts)
            end,
        })

        autocmd_enabled = true
        print("Diagnostics autocmd enabled")
    end
end

Toggle_diagnostics_autocmd()

nmap("<Leader>e", ":lua Toggle_diagnostics_autocmd()<CR>")

nmap("<Up>", "<NOP>")
nmap("<Down>", "<NOP>")
nmap("<Left>", "<NOP>")
nmap("<Right>", "<NOP>")
