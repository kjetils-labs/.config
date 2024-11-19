
vim.g.mapleader = " "

function map(mode, shortcut, command) 
	vim.keymap.set(mode, shortcut, command, { noremap = true, silent = true })
end

function nmap(shortcut, command)
	map("n", shortcut, command)
end

function imap(shortcut, command)
	nmap("i", shortcut, command)
end

nmap("<Leader>pv", vim.cmd.Ex)

nmap("<Up>", "<NOP>")
nmap("<Down>", "<NOP>")
nmap("<Left>", "<NOP>")
nmap("<Right>", "<NOP>")
-- vim.keymap.set("n", "<leader>pv", vim.cmd.ex)


