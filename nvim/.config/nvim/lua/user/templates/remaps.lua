local templates = require("user.templates.templates")
local util = require("user.templates.util")

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- remaps for templates
for _, t in ipairs(templates) do
  local cmd = util.get_read_cmd(t);
  keymap(
    'n',
    '<leader>' .. t.mapping,
    ':' .. cmd.read .. '<CR>' .. cmd.move,
    vim.tbl_extend('force', opts, { desc = 'Read ' .. t.desc })
  )
end

keymap('n', '<leader>tp', ':Temp<CR>', vim.tbl_extend('force', opts, { desc = "Pick and insert template" }))
keymap('n', '<leader>showtp', ':List<CR>', vim.tbl_extend('force', opts, { desc = "Show available templates" }))
