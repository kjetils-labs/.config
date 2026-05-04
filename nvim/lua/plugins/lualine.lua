return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("lualine").setup({
			options = {
				theme = "codedark",
			},
			sections = {
				lualine_a = {
					{
						"filename",
						path = 3,
					},
				},
			},
		})
	end,
}
