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
		opts = {
			auto_install = true,
			handlers = {
				function(server_name)
					local capabilities = require("cmp_nvim_lsp").default_capabilities()

					require("lspconfig")[server_name].setup({
						capabilities = capabilities,
					})
				end,

				-- Custom gopls config
				["gopls"] = function()
					local capabilities = require("cmp_nvim_lsp").default_capabilities()
					require("lspconfig").gopls.setup({
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
					local capabilities = require("cmp_nvim_lsp").default_capabilities()
					require("lspconfig").lua_ls.setup({
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
			},
		},
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
		config = function()
			local keymap = vim.keymap.set
			local opts = { noremap = true, silent = true }

			keymap("n", "K", vim.lsp.buf.hover, opts)
			keymap("n", "gd", vim.lsp.buf.definition, opts)
			keymap("n", "gD", vim.lsp.buf.declaration, opts)
			keymap("n", "gi", vim.lsp.buf.implementation, opts)
			keymap("n", "go", vim.lsp.buf.type_definition, opts)
			keymap("n", "gr", vim.lsp.buf.references, opts)
			keymap("n", "gs", vim.lsp.buf.signature_help, opts)
			keymap("n", "<F2>", vim.lsp.buf.rename, opts)
			keymap({ "n", "x" }, "<F3>", function()
				vim.lsp.buf.format({ async = true })
			end, opts)
			keymap("n", "<F4>", vim.lsp.buf.code_action, opts)
		end,
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
					"iferr",
					"impl",
					condition = function()
						return vim.fn.executable("go") == 1
					end,
				},

				"prettier",
				"stylua",
				"eslint_d",
				"dotenv-linter",
			},
			auto_update = false,
			-- run_on_start = true,
		},
		config = function(_, opts)
			require("mason-tool-installer").setup(opts)
		end,
	},
}
