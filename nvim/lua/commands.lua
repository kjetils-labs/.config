vim.api.nvim_create_user_command("GoModifyTags", function(opts)
    local file = vim.fn.expand("%:p")
    local args = vim.split(opts.args, " ")
    local tags = nil
    local remove_tags = nil
    local struct_name = nil

    -- Check for visual selection (if user is in visual mode)
    local mode = vim.fn.mode()
    if mode == "v" or mode == "V" then
        vim.cmd('normal! "vy') -- yank visual selection into register v
        struct_name = vim.fn.getreg("v"):gsub("\n", ""):gsub("^%s+", ""):gsub("%s+$", "")
    end

    -- Parse args with support for aliases
    for _, arg in ipairs(args) do
        if arg:match("^%-s=") then
            struct_name = arg:gsub("^%-s=", "")
        elseif arg:match("^%-r=") then
            remove_tags = arg:gsub("^%-r=", "")
        elseif arg ~= "" and not arg:match("^%-[sr]=") then
            tags = arg -- assume it's an add-tags argument like "json"
        end
    end

    -- Fallback to word under cursor if no struct provided
    if not struct_name or struct_name == "" then
        struct_name = vim.fn.expand("<cword>")
    end

    -- If no tags or remove-tags specified, toggle json
    if not tags and not remove_tags then
        -- Try to detect if json is already in the struct
        local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
        local json_tag_found = false
        local inside_struct = false
        for _, line in ipairs(lines) do
            if line:match("type%s+" .. struct_name .. "%s+struct%s*{") then
                inside_struct = true
            elseif inside_struct and line:match("^}") then
                inside_struct = false
            elseif inside_struct and line:match('`.*json:"[^"]+"') then
                json_tag_found = true
                break
            end
        end

        if json_tag_found then
            remove_tags = "json"
        else
            tags = "json"
        end
    end

    local cmd_parts = { "gomodifytags", "-file", file }

    if struct_name and struct_name ~= "" then
        table.insert(cmd_parts, "-struct")
        table.insert(cmd_parts, struct_name)
    else
        -- fallback to using line number
        local line = vim.fn.line(".")
        table.insert(cmd_parts, "-line")
        table.insert(cmd_parts, tostring(line))
    end

    if tags then
        table.insert(cmd_parts, "-add-tags")
        table.insert(cmd_parts, tags)
    end

    if remove_tags then
        table.insert(cmd_parts, "-remove-tags")
        table.insert(cmd_parts, remove_tags)
    end

    table.insert(cmd_parts, "-w")

    local cmd = table.concat(cmd_parts, " ")

    vim.fn.jobstart(cmd, {
        on_exit = function()
            vim.schedule(function()
                vim.cmd("edit") -- reload file
                print("GoModifyTags: Updated struct " .. (struct_name or "(line)") ..
                    (tags and (" | +tags: " .. tags) or "") ..
                    (remove_tags and (" | -tags: " .. remove_tags) or ""))
            end)
        end,
    })
end, {
    nargs = "*",
    ---@diagnostic disable-next-line: unused-local
    complete = function(ArgLead, CmdLine, CursorPos)
        local static_tags = { "json", "yaml", "xml", "bson", "db", "mapstructure" }
        local completions = {}

        for _, tag in ipairs(static_tags) do
            table.insert(completions, tag)
            table.insert(completions, "-r=" .. tag)
        end

        local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
        for _, line in ipairs(lines) do
            local struct_name = line:match("^%s*type%s+([%w_]+)%s+struct%s*{")
            if struct_name then
                table.insert(completions, "-s=" .. struct_name)
            end
        end

        return completions
    end,
    desc =
    "Add/remove tags to Go structs. Usage: :GoModifyTags [tags] [-r=tags (remove tags)] [-s=name (add to struct)]",
})
