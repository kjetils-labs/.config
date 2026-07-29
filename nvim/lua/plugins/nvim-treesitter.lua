return {
	-- Treesitter is a new parser generator tool that we can
	-- use in Neovim to power faster and more accurate
	-- syntax highlighting.
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",

	opts = {
		auto_install = true,
		highlight = { enable = true },
		indent = { enable = true },
	},
	init = function()
		-- 	require("nvim-treesitter").install({
		-- 		"go",
		-- 		"gomod",
		-- 		"gosum",
		-- 		"lua",
		-- 		"vim",
		-- 		"vimdoc",
		-- 		"json",
		-- 		"yaml",
		-- 		"markdown",
		-- 		"markdown_inline",
		-- 		"dockerfile",
		-- 		"gitcommit",
		-- 		"gitignore",
		-- 		"bash",
		-- 		-- web stuff
		-- 		"css",
		-- 		"html",
		-- 		"javascript",
		-- 		"typescript",
		-- 	})
		--
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
