return {
	-- Treesitter is a new parser generator tool that we can
	-- use in Neovim to power faster and more accurate
	-- syntax highlighting.
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",

	config = function()
		local configs = require("nvim-treesitter.configs")

		---@diagnostic disable-next-line: missing-fields
		configs.setup({
			ensure_installed = {
				"go",
				"gomod",
				"gosum",
				"lua",
				"vim",
				"vimdoc",
				"json",
				"yaml",
				"markdown",
				"markdown_inline",
				"dockerfile",
				"gitcommit",
				"gitignore",
				"bash",
				-- web stuff
				"css",
				"html",
				"javascript",
				"typescript",
			},
			auto_install = true,
			highlight = { enable = true },
			indent = { enable = true },
		})
	end,
}
