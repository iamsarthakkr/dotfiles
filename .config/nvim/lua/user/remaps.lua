local keymap = vim.keymap

-- Move selected line/block up/down in visual mode
keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selected lines down" })
keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selected lines up" })

-- Duplicate current line up/down in normal mode
keymap.set("n", "<leader>j", "mzyyp`z", { desc = "Duplicate line down" })
keymap.set("n", "<leader>k", "mzyyP`z", { desc = "Duplicate line up" })

-- Join lines and keep cursor position in normal mode
keymap.set("n", "J", "mzJ`z", { desc = "Join next line keeping the cursor intact" })

-- Paste over selection without yanking in visual mode
keymap.set("v", "<leader>p", "\"_dP", { desc = "Paste without yanking" })

-- Yank to system clipboard in normal and visual modes
keymap.set({ "n", "v" }, "<leader>Y", [["+Y]], { desc = "Copy to system clipboard" })

-- Delete to void register in normal and visual modes
keymap.set({ "n", "v" }, "<leader>d", "\"_d", { desc = "Delete to void register" })

-- use jk to exit insert mode
keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })

-- delete single character without copying into register
keymap.set("n", "x", '"_x', { desc = "Delete character without copying into register" })

-- increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" }) -- increment
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" }) -- decrement

-- window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window
--
-- Use Ctrl + arrow keys to move between splits
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Go to left split" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Go to below split" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Go to above split" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Go to right split" })

keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" }) -- open new tab
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" }) -- close current tab
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" }) --  go to next tab
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" }) --  go to previous tab
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab

for i = 1, 9 do
  keymap.set("n", "<leader>t" .. i, i .. "gt", { desc = "Go to tab " .. i })
end
