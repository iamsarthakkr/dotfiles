
-- Move selected line/block up/down in visual mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Duplicate current line up/down in normal mode
vim.keymap.set("n", "<leader>j", "yyp", { desc = "Duplicate line down" })
vim.keymap.set("n", "<leader>k", "yyP", { desc = "Duplicate line up" })

-- Join lines and keep cursor position in normal mode
vim.keymap.set("n", "J", "mzJ`z")

-- Paste over selection without yanking in visual mode
vim.keymap.set("v", "<leader>p", "\"_dP")

-- Yank to system clipboard in normal and visual modes
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- Delete to void register in normal and visual modes
vim.keymap.set({ "n", "v" }, "<leader>d", "\"_d")
