vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("lsp_format_on_save", { clear = true }),
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if not client then
			return
		end

		-- Optional: skip some LSP clients from formatting
		local skip_formatters = { "ts_ls", "vtsls" } -- add others if needed
		if vim.tbl_contains(skip_formatters, client.name) then
			return
		end

		if client.server_capabilities.documentFormattingProvider then
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = vim.api.nvim_create_augroup("format_on_save_" .. args.buf, { clear = true }),
				buffer = args.buf,
				callback = function()
					vim.lsp.buf.format({
						async = false,
						filter = function(c)
							-- Prefer null-ls if it's available
							if c.name == "null-ls" then
								return true
							end
							return not vim.tbl_contains(skip_formatters, c.name)
						end,
					})
				end,
			})
		end
	end,
})

vim.api.nvim_create_autocmd("VimEnter", {
	desc = "Open Neotree automatically if starting in a directory",
	group = vim.api.nvim_create_augroup("neotree", { clear = true }),
	callback = function()
		local arg = vim.fn.argv(0)
		if arg and vim.fn.isdirectory(arg) == 1 then
			vim.cmd("Neotree show")
			vim.cmd.cd(arg)
		end
	end,
})

local group = vim.api.nvim_create_augroup("DiagnosticsGroup", { clear = true })

local function show_diagnostics_float()
	vim.diagnostic.open_float(nil, {
		focusable = false,
		close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
		border = "rounded",
		source = "always",
		prefix = " ",
		scope = "cursor",
	})
end

local diagnostics_autocmd_id

-- Toggles the diagnostics popup on CursorHold (mapped to <Leader>e)
function Toggle_diagnostics_autocmd(silent)
	if diagnostics_autocmd_id then
		vim.api.nvim_del_autocmd(diagnostics_autocmd_id)
		diagnostics_autocmd_id = nil
		if not silent then
			vim.notify("Diagnostics popup off")
		end
	else
		diagnostics_autocmd_id = vim.api.nvim_create_autocmd("CursorHold", {
			group = group,
			callback = show_diagnostics_float,
		})
		if not silent then
			vim.notify("Diagnostics popup on")
		end
	end
end

Toggle_diagnostics_autocmd(true)
