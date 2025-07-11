local M = {}

local state = {
	float = {
		win = -1,
		buf = -1,
		chan = -1
	},
	buf_dir = ""
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

-- Function to send a command to the floating terminal
M.send_to_terminal = function(cmd)
	if state.float.chan ~= nil and state.float.chan > 0 then
		vim.api.nvim_chan_send(state.float.chan, cmd .. "\n")
	else
		vim.notify("Floating terminal is not open!", vim.log.levels.WARN)
	end
end

M.toggle_terminal = function(opts)
	if not vim.api.nvim_win_is_valid(state.float.win) then
		local buf_dir = vim.fn.expand('%:p:h')
		local chan_nr = state.float.chan
		state.float = open_centered_float({
			buf = state.float.buf,
		})
		state.float.chan = chan_nr
		if vim.bo[state.float.buf].buftype ~= "terminal" then
			vim.api.nvim_set_current_win(state.float.win)
			state.float.chan = vim.fn.termopen(os.getenv("SHELL") or "sh")
			vim.bo[state.float.buf].buftype = "terminal"
		end

		if state.buf_dir ~= buf_dir then
			M.send_to_terminal("cd " .. buf_dir .. " && clear")
			state.buf_dir = buf_dir
		end
		vim.cmd("startinsert")
	else
		-- close window	
		vim.api.nvim_win_hide(state.float.win)
	end
end

M.is_open = function()
	return	vim.api.nvim_win_is_valid(state.float.win)
end

vim.api.nvim_create_user_command("Float", M.toggle_terminal , {
	nargs = "*",
	desc = "Open a centered floating window. Usage: :CenteredFloat [width_percent] [height_percent]",
})

vim.keymap.set({"n", "t"}, "<C-t>", M.toggle_terminal, { desc = "Toggle floating terminal" })

return M
