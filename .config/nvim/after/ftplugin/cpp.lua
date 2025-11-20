local floating = require("user.custom.floating")
local keymap = vim.keymap

keymap.set("n", "<leader>rf", function()
    local filename = vim.fn.expand("%:t")
    if floating.is_open() then
        return
    end
    floating.toggle_terminal()
    floating.send_to_terminal("localRun " .. filename)
end, { buffer = true, desc = "run current file for file input" })

keymap.set("n", "<F9>", function()
    local filename = vim.fn.expand("%:t")
    if floating.is_open() then
        return
    end
    floating.toggle_terminal()
    floating.send_to_terminal("localCompile " .. filename)
end, { buffer = true, desc = "compiling current file" })
