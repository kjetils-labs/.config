return {
    "lewis6991/gitsigns",
    event = "BufReadPre",
    url = "git@github.com:lewis6991/gitsigns.nvim.git",
    config = function()
        require('gitsigns').setup({
            signs                        = {
                add          = { text = '┃' },
                change       = { text = '┃' },
                delete       = { text = '_' },
                topdelete    = { text = '‾' },
                changedelete = { text = '~' },
                untracked    = { text = '┆' },
            },
            signs_staged                 = {
                add          = { text = '┃' },
                change       = { text = '┃' },
                delete       = { text = '_' },
                topdelete    = { text = '‾' },
                changedelete = { text = '~' },
                untracked    = { text = '┆' },
            },
            current_line_blame_formatter = '<author>, <author_time:%R> - <summary>',
            sign_priority                = 6,
            max_file_length              = 40000, -- Disable if file is longer than this (in lines)
            -- linehl                       = true,  -- Enables :Gitsigns toggle_numhl on launch
        })
    end,
}
