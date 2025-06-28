vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.nu = true 
vim.opt.relativenumber = true

vim.opt.tabstop = 4 
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.termguicolors = true

vim.opt.smartindent = true
vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.colorcolumn = "80"

vim.api.nvim_set_hl(0, "Cursor", { fg = "blue", bg = "#00a48f" })
vim.api.nvim_set_hl(0, "iCursor", { fg = "black", bg = "#00a48f" })

-- Configure guicursor options
vim.opt.guicursor = {
    "n-v-c:block-Cursor",       -- Normal, Visual, and Command-line modes use block cursor
    "i:ver100-iCursor",         -- Insert mode uses vertical bar cursor with 100% height
    "n-v-c:blinkon0",           -- Disable blinking for Normal, Visual, and Command-line modes
    "i:blinkwait10"             -- Insert mode waits 10ms before blinking
}
