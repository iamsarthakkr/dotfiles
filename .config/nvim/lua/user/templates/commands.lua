local util = require("user.templates.util")
local templates = require("user.templates.templates")

vim.api.nvim_create_user_command("Temp", util.TemplatePicker, {})
vim.api.nvim_create_user_command('List', util.show_templates, {})
