local floating = require("user.custom.floating")
local keymap = vim.keymap

print("hello from cpp")

keymap.set("n", "<leader>rf", function()
	local filename = vim.fn.expand("%:t")
	if floating.is_open() then return end
	floating.toggle_terminal()
	floating.send_to_terminal("localRun " .. filename)
end, { buffer = true, desc = "run current file for file input" })
