local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

keymap("n", "<leader>vc", "zz", opts)
keymap("n", "<leader>gb", "G$", opts)
keymap("n", "<leader>sf", ":w<CR>", opts)
