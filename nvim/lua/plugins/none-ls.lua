return {
    "nvimtools/none-ls.nvim",
    config = function()
        local null_ls = require("null-ls")
        null_ls.setup({
            null_ls.builtins.formatting.stylua,
            null_ls.builtins.formatting.prettier,
            null_ls.builtins.formatting.eslint,
            null_ls.builtins.completion.spell,
            null_ls.builtins.code_actions.gomodifytags.with({
                filetypes = { "go" }
            }),
            null_ls.builtins.diagnostics.dotenv_linter.with({
                filetypes = { "sh" }
            }),
            null_ls.builtins.diagnostics.golangci_lint.with({
                filetypes = { "go" }
            }),

        })
    end,
}
