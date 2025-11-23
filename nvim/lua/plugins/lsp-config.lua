return {
	{
		"mason-org/mason.nvim",
		dependencies = {
			"neovim/nvim-lspconfig",
		},
		config = function()
			require("mason").setup()
		end,
	},

	{
		"mason-org/mason-lspconfig.nvim",
		lazy = false,
		opts = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			local on_attach = function(client, bufnr)
				local keymap = vim.keymap.set
				local opts = { noremap = true, silent = true, buffer = bufnr }

				keymap("n", "K", vim.lsp.buf.hover, opts)
				keymap("n", "gd", vim.lsp.buf.definition, opts)
				keymap("n", "gD", vim.lsp.buf.declaration, opts)
				keymap("n", "gi", vim.lsp.buf.implementation, opts)
				keymap("n", "go", vim.lsp.buf.type_definition, opts)
				keymap("n", "gr", vim.lsp.buf.references, opts)
				keymap("n", "gs", vim.lsp.buf.signature_help, opts)
				keymap("n", "<F4>", vim.lsp.buf.rename, opts)

				if client.server_capabilities.documentFormattingProvider then
					keymap({ "n", "x" }, "<F2>", function()
						vim.lsp.buf.format({ async = true })
					end, opts)
				end

				keymap("n", "<F3>", vim.lsp.buf.code_action, opts)
			end

			return {
				auto_install = true,
				handlers = {
					function(server_name)
						require("lspconfig")[server_name].setup({
							on_attach = on_attach,
							capabilities = capabilities,
						})
					end,

					-- Custom gopls config
					["gopls"] = function()
						require("lspconfig").gopls.setup({
							on_attach = on_attach,
							capabilities = capabilities,
							settings = {
								gopls = {
									usePlaceholders = true,
									staticcheck = true,
									completeUnimported = true, -- autocompletion for packages not yet imported
									analyses = {
										unusedparams = true,
										shadow = true,
										fieldalignment = true, -- suggest field reordering to reduce struct size
									},
									codelenses = {
										generate = true, -- enable go:generate lens
										gc_details = true, -- show GC details
										test = true, -- run tests via code lens
									},
								},
							},
						})
					end,

					-- Custom lua_ls config
					["lua_ls"] = function()
						require("lspconfig").lua_ls.setup({
							on_attach = on_attach,
							capabilities = capabilities,
							settings = {
								Lua = {
									diagnostics = {
										globals = { "vim" },
									},
									workspace = {
										checkThirdParty = false,
									},
								},
							},
						})
					end,
					-- Custom angularls config
					["angularls"] = function()
						require("lspconfig").angularls.setup({
							on_attach = on_attach,
							capabilities = capabilities,
						})
					end,
					-- Custom typescript config
					["tsserver"] = function()
						require("lspconfig").angularls.setup({
							on_attach = on_attach,
							capabilities = capabilities,
						})
					end,
				},
			}
		end,
		config = function()
			require("mason-lspconfig").setup()
		end,
	},

	{
		"neovim/nvim-lspconfig",
		lazy = false,
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			{ "folke/neodev.nvim", opts = {} },
		},
		config = function() end,
	},

	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		dependencies = {
			"williamboman/mason.nvim",
		},
		opts = {
			ensure_installed = {

				-- Go stuff
				{
					"gopls",
					"golangci-lint",
					"gomodifytags",
					"goimports",
					"iferr",
					"impl",
					condition = function()
						return vim.fn.executable("go") == 1
					end,
				},

				-- C++ stuff
				{
					"clangd",
					condition = function()
						return vim.fn.executable("cpp") == 1
					end,
				},

				-- Markdown stuff
				{
					"prettier",
					"markdownlint",
					"markdown-oxide",
					condition = function()
						return vim.fn.executable("md") == 1
					end,
				},

				"prettier",
				"stylua",
				"eslint_d",
				"dotenv-linter",
				"typescript-language-server",
				"angular-language-server",
				"angularls",
				"lua_ls",
				"cssls",
				"html",
			},
			auto_update = false,
			-- run_on_start = true,
		},
		config = function(_, opts)
			require("mason-tool-installer").setup(opts)
		end,
	},
}
