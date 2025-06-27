local templates = require("user.templates.templates")
local template_dir = "~/Work/Cpp/Templates/"

local function get_read_cmd(t)
	return { read = '-1read ' .. template_dir .. t.file, move = t.move }
end

local function TemplatePicker()
  local items = {}
  local key_map = {} for _, t in ipairs(templates) do
    local item = t.desc .. " (" .. t.mapping .. ")"
    table.insert(items, item)
    key_map[item] = t
  end

  vim.ui.select(items, { prompt = "Select a template:" }, function(choice)
    if not choice then return end
    local t = key_map[choice]
    if t then
		local cmd = get_read_cmd(t)
		vim.cmd(cmd.read)
		-- vim.cmd('normal! ' .. cmd.move)
    end
  end)
end


local function show_templates_window()
  local lines = { "Available Templates:" }
  for _, t in ipairs(templates) do
    table.insert(lines, string.format("%s (%s)", t.desc, t.mapping))
  end

  -- Create a scratch buffer
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

  -- Calculate window size
  local width = 60
  local height = #lines + 2
  local opts = {
    style = "minimal",
    relative = "editor",
    width = width,
    height = height,
    row = (vim.o.lines - height) / 2,
    col = (vim.o.columns - width) / 2,
    border = "rounded",
  }

  -- Open floating window
  vim.api.nvim_open_win(buf, true, opts)
end

return {
  TemplatePicker = TemplatePicker,
  get_read_cmd = get_read_cmd,
  show_templates = show_templates_window
}
