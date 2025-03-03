local M = {}

local start = vim.health.start
local ok = vim.health.ok
local warn = vim.health.warn
local error = vim.health.error

function M.check()
    start("LazyVim")

    if vim.fn.has("nvim-0.9.0") == 1 then
        ok("Using Neovim >= 0.9.0")
        if vim.fn.has("nvim-0.10.0") == 0 then
            warn("Use Neovim >= 0.10.0 for the best experience")
        end
    else
        error("Neovim >= 0.9.0 is required")
    end

    for _, cmd in ipairs({ "git", "rg", { "fd", "fdfind" }, "lazygit", "fzf", "curl" }) do
        local name = type(cmd) == "string" and cmd or vim.inspect(cmd)
        local commands = type(cmd) == "string" and { cmd } or cmd
        ---@cast commands string[]
        local found = false

        for _, c in ipairs(commands) do
            if vim.fn.executable(c) == 1 then
                name = c
                found = true
            end
        end

        if found then
            ok(("`%s` is installed"):format(name))
        else
            warn(("`%s` is not installed"):format(name))
        end
    end
end

return M
