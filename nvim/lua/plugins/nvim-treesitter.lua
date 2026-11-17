return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	branch = "main",

	config = function()
		local ts = require("nvim-treesitter")
		ts.setup()
		ts.install({
			"bash",
			"css",
			"diff",
			"dockerfile",
			"gitcommit",
			"gitignore",
			"go",
			"gomod",
			"gosum",
			"gotmpl",
			"helm",
			"html",
			"javascript",
			"json",
			"lua",
			"markdown",
			"markdown_inline",
			"tsx",
			"typescript",
			"vim",
			"vimdoc",
			"xml",
			"yaml",
		})
		-- vim-go sets *.tmpl to gohtmltmpl; use the gotmpl parser for those filetypes
		vim.treesitter.language.register("gotmpl", { "gohtmltmpl", "gotexttmpl" })

		-- Pick the injected language for text outside {{ }} per buffer (see queries/gotmpl/injections.scm)
		local by_ext = { html = "html", yaml = "yaml", yml = "yaml", json = "json", sh = "bash", md = "markdown" }
		vim.treesitter.query.add_directive("inject-by-buffer!", function(_, _, source, _, metadata)
			local bufnr = type(source) == "number" and source or 0
			-- helm queries inherit gotmpl and already inject yaml
			if vim.bo[bufnr].filetype == "helm" then
				return
			end
			local name = vim.api.nvim_buf_get_name(bufnr)
			if name:match("%.gohtml$") then
				metadata["injection.language"] = "html"
				return
			end
			-- foo.yaml.tmpl, foo.html.gotmpl, ...
			local ext = name:match("%.(%w+)%.g?o?tmpl$")
			metadata["injection.language"] = by_ext[ext] or "go"
		end, { force = true })
	end,
	init = function()
		vim.api.nvim_create_autocmd("FileType", {
			callback = function()
				-- Enable treesitter highlighting and disable regex syntax
				pcall(vim.treesitter.start)
				-- Enable treesitter-based indentation
				vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
			end,
		})
	end,
}
