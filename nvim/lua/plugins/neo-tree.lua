return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
	},
	{
		"antosha417/nvim-lsp-file-operations",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-neo-tree/neo-tree.nvim", -- makes sure that this loads after Neo-tree.
		},
		config = function()
			require("lsp-file-operations").setup()
			require("neo-tree").setup({
				enable_git_status = true,
				filesystem = {
					follow_current_file = true,
					se_libuv_file_watcher = true,
				},
				follow_current_file = {
					enabled = true,
				},

				buffers = {
					follow_current_file = {
						enabled = true,
					},
				},
				watchers = {
					enabled = true,
					interval = 1000,
					follow_current_file = {
						enabled = true,
					},
				},
			})

			local events = require("neo-tree.events")
			events.fire_event(events.GIT_EVENT)
		end,
	},
}
