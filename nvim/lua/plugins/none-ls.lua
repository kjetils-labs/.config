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
                        args = { "--output.json.path=stdout" },
                        filetypes = { "go" },
                    }),
                    null_ls.builtins.code_actions.impl,
                },
            })
        end,
    },
    {
        "jay-babu/mason-null-ls.nvim",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "williamboman/mason.nvim",
            "nvimtools/none-ls.nvim",
        },
        config = function()
            require("mason").setup()
            require("mason-null-ls").setup({
                ensure_installed = {
                    "prettier",

                    -- Go stuff
                    "gomodifytags",
                    "golangci_lint",

                    "dotenv_linter",
                    "impl",
                },
            })
        end,
    },
}
