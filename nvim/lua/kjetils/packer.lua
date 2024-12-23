vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)

	use 'wbthomason/packer.nvim'
	use {
		'nvim-telescope/telescope.nvim',
		tag = '0.1.8',
		requires =  {{'nvim-lua/plenary.nvim' }}
	}
	use ({ 'rose-pine/neovim',
		as = 'rose-pine',
		config = function()
			vim.cmd('colorscheme rose-pine')
		end
	})
	use ('nvim-treesitter/nvim-treesitter',	{ run = ':TSUpdate'})

    -- LSP requirements
    use ({'VonHeikemen/lsp-zero.nvim', branch = 'v4.x'})
    use ({'neovim/nvim-lspconfig'})
    use ({'hrsh7th/nvim-cmp'})
    use ({'hrsh7th/cmp-nvim-lsp'})


    use ({'fatih/vim-go'})
    use ({"williamboman/mason.nvim"})

    use {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        requires = { 
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim",
            -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
        }
    }

    -- Adds the tmux navigator support for vim
    use 'christoomey/vim-tmux-navigator'

end)
