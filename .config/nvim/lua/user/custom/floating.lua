local state = {
	float = {
		win = -1,
		buf = -1
	}
}

local function open_centered_float(opts)
	opts = opts or {}
	local width = math.floor((opts.width or 0.8) * vim.o.columns)
	local height = math.floor((opts.height or 0.8) * vim.o.lines)
	local row = math.floor((vim.o.lines - height) / 2)
	local col = math.floor((vim.o.columns - width) / 2)

	local bufnr = opts.buf or -1
	local buf = nil
	if vim.api.nvim_buf_is_valid(bufnr) then
		buf = opts.buf
	else
		buf = vim.api.nvim_create_buf(false, true)
	end
	local win = vim.api.nvim_open_win(buf, true, {
		relative = "editor",
		width = width,
		height = height,
		row = row,
		col = col,
		style = "minimal",
		border = "rounded",
	})
	return { buf = buf, win = win }
end

local function toggle_terminal(opts)
	if not vim.api.nvim_win_is_valid(state.float.win) then
		state.float = open_centered_float({
			buf = state.float.buf,
		})
		if vim.bo[state.float.buf].buftype ~= "terminal" then
			vim.api.nvim_set_current_win(state.float.win)
			vim.fn.termopen(os.getenv("SHELL") or "sh")
			vim.bo[state.float.buf].buftype = "terminal"
		end
		vim.cmd("startinsert")
	else
		-- close window	
		vim.api.nvim_win_hide(state.float.win)
	end
end

vim.api.nvim_create_user_command("Float", toggle_terminal , {
	nargs = "*",
	desc = "Open a centered floating window. Usage: :CenteredFloat [width_percent] [height_percent]",
})

vim.keymap.set({"n", "t"}, "<C-t><C-t>", toggle_terminal, { desc = "Toggle floating terminal" })

