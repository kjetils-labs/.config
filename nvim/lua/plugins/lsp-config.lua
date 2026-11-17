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
		config = function()
			vim.lsp.config("*", {
				capabilities = require("cmp_nvim_lsp").default_capabilities(),
			})

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

			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("user_lsp_keymaps", { clear = true }),
				callback = function(args)
					local client = vim.lsp.get_client_by_id(args.data.client_id)
					if client then
						on_attach(client, args.buf)
					end
				end,
			})

			vim.lsp.config("gopls", {
				filetypes = { "go", "gomod", "gowork", "gotmpl", "gohtmltmpl", "gotexttmpl" },
				settings = {
					gopls = {
						templateExtensions = { "gohtml", "html", "gotmpl", "tmpl" },
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

			vim.lsp.config("lua_ls", {
				settings = {
					Lua = {
						diagnostics = { globals = { "vim" } },
						workspace = { checkThirdParty = false },
					},
				},
			})

			vim.lsp.config("helm_ls", {
				settings = {
					["helm-ls"] = {
						yamlls = { path = "yaml-language-server" },
					},
				},
			})

			-- mason-lspconfig v2 auto-enables installed servers with vim.lsp.enable
			-- ts_ls and vtsls overlap; keep vtsls only
			require("mason-lspconfig").setup({
				automatic_enable = { exclude = { "ts_ls" } },
			})
		end,
	},

	{
		"neovim/nvim-lspconfig",
		lazy = false,
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
		},
		config = function() end,
	},

	{
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {
			library = {
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			},
		},
	},

	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		dependencies = {
			"mason-org/mason.nvim",
		},
		opts = function()
			local function has(...)
				for _, exe in ipairs({ ... }) do
					if vim.fn.executable(exe) == 1 then
						return true
					end
				end
				return false
			end

			-- mason-tool-installer only reads the first name of each entry,
			-- so every tool gets its own entry
			local function when(cond, tools)
				return vim.tbl_map(function(tool)
					return {
						tool,
						condition = function()
							return cond
						end,
					}
				end, tools)
			end

			local tools = {
				"prettier",
				"stylua",
				"eslint_d",
				"dotenv-linter",
				"markdownlint",
				"markdown-oxide",
				"typescript-language-server",
				"angular-language-server",
				"lua-language-server",
				"css-lsp",
				"html-lsp",
				"vtsls",
			}
			vim.list_extend(
				tools,
				when(has("go"), { "gopls", "golangci-lint", "gomodifytags", "goimports", "iferr", "impl" })
			)
			vim.list_extend(tools, when(has("clang", "gcc", "g++", "cc"), { "clangd" }))
			vim.list_extend(tools, when(has("docker", "podman"), { "docker-language-server" }))
			vim.list_extend(tools, when(has("python3", "python"), { "python-lsp-server", "basedpyright" }))

			return {
				ensure_installed = tools,
				auto_update = false,
				-- run_on_start = true,
			}
		end,
		config = function(_, opts)
			require("mason-tool-installer").setup(opts)
		end,
	},
}
