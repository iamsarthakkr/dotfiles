vim.cmd("let g:netrw_liststyle = 3")

local opt = vim.opt -- for conciseness

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.o.timeout = true
vim.o.timeoutlen = 5000
vim.o.clipboard = "unnamedplus"
vim.o.foldenable = false

-- line numbers
opt.relativenumber = true -- show relative line numbers
opt.number = true         -- shows absolute line number on cursor line (when relative number is on)

-- tabs & indentation
opt.tabstop = 4       -- 4 spaces for tabs (prettier default)
opt.shiftwidth = 4    -- 4 spaces for indent width
opt.softtabstop = 4   -- 4 space for indent
opt.expandtab = true  -- expand tab to spaces
opt.autoindent = true -- copy indent fromocurrent line when starting new one

-- turn on termguicolors for colorscheme to work
-- (have to use iterm2 or any other true color terminal)
opt.termguicolors = true
opt.background = "dark" -- colorschemes that can be light or dark will be made dark
opt.signcolumn = "yes"  -- show sign column so that text doesn't shift

opt.smartindent = true

-- cursor line
opt.cursorline = true -- highlight the current cursor line

-- line wrapping
opt.wrap = false -- disable line wrappinge

opt.swapfile = false
opt.backup = false
opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
opt.undofile = true

opt.hlsearch = false
opt.incsearch = true

-- search settings
opt.ignorecase = true -- ignore case when searching
opt.smartcase = true  -- if you include mixed case in your search, assumes you want case-sensitive

-- backspace
opt.backspace = "indent,eol,start" -- allow backspace on indent, end of line or insert mode start position

-- split windows
opt.splitright = true -- split vertical window to the right
opt.splitbelow = true -- split horizontal window to the bottom

-- turn off swapfile
opt.swapfile = false

opt.scrolloff = 8 -- scroll offset for top and bottom
opt.isfname:append("@-@")

opt.updatetime = 50

opt.colorcolumn = "120"

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight while yanking",
	group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

vim.api.nvim_create_autocmd("TermOpen", {
	desc = "terminal open",
	group = vim.api.nvim_create_augroup("terminal-open", { clear = true }),
	callback = function()
		vim.cmd("startinsert")
	end,
})
