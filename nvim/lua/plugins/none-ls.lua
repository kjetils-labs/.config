return {
    {
        "nvimtools/none-ls.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            local null_ls = require("null-ls")
            null_ls.setup({
                sources = {

                    -- Formatters
                    null_ls.builtins.formatting.stylua,
                    null_ls.builtins.formatting.prettier,
                    null_ls.builtins.formatting.eslint,

                    -- Completion
                    null_ls.builtins.completion.spell,

                    -- Code actions
                    null_ls.builtins.code_actions.gomodifytags.with({
                        filetypes = { "go" },
                    }),

                    -- Diagnostics
                    null_ls.builtins.diagnostics.dotenv_linter.with({
                        filetypes = { "sh" },
                    }),
                    null_ls.builtins.diagnostics.golangci_lint.with({
                        filetypes = { "go" },
                    }),
                    null_ls.builtins.code_actions.impl,
                    null_ls.builtins.code_actions.iferr,
                },
            })
        end,
    },
    {
        "jay-babu/mason-null-ls.nvim",
        dependencies = {
            "williamboman/mason.nvim",
            "nvimtools/none-ls.nvim",
        },
        opts = {
            automatic_installation = true,
        },
        config = function(_, opts)
            require("mason-null-ls").setup(opts)
        end,
    },
}
