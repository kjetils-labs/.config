return {
    {
        "mason-org/mason.nvim",
        dependencies = {
            "mason-org/mason-lspconfig.nvim",
            "WhoIsSethDaniel/mason-tool-installer.nvim",
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
            automatic_installation = true,
            ensure_installed = {
                "gopls",
                "html",
                "jsonls",
                "dockerls",
                "bashls",
                "jsonls",
                "lua_ls",
                "dockerls",
                "prettier",
                "stylua", -- lua formatter
                "isort",  -- python formatter
                "black",  -- python formatter
                "pylint",
                "eslint_d",
            },
        },
        config = function()
            require("mason-lspconfig").setup()
        end,
    },
    -- Connects mason to the lsp
    {
        "neovim/nvim-lspconfig",

        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            { "folke/neodev.nvim", opts = {} },
        },
        config = function()
            local capabilities = require("cmp_nvim_lsp").default_capabilities()
            local lspconfig = require("lspconfig")

            lspconfig.gopls.setup({
                capabilities = capabilities
            })

            lspconfig.jsonls.setup({
                capabilities = capabilities
            })

            lspconfig.lua_ls.setup({
                capabilities = capabilities,
                filetypes = {
                    "lua",
                }
            })

            lspconfig.bashls.setup({
                capabilities = capabilities,
                filetypes = {
                    "sh",
                    "zsh",
                },
            })

            lspconfig.dockerls.setup({
                capabilities = capabilities,
                -- filetypes = {
                -- }
            })

            vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', {})
            vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', {})
            vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', {})
            vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', {})
            vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', {})
            vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', {})
            vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', {})
            vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', {})
            vim.keymap.set({ 'n', 'x' }, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', {})
            vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', {})
        end,
    }
}
