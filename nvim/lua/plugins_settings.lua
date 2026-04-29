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
})
