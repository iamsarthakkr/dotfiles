return {
	'akinsho/bufferline.nvim',
	version = "*",
	dependencies = 'nvim-tree/nvim-web-devicons',
	config = function()
		local bufferline = require('bufferline')
		bufferline.setup {
			options = {
				mode = "tabs", -- set to "tabs" to only show tabpages instead
				style_preset = bufferline.style_preset.default, -- or bufferline.style_preset.minimal,
				themable = true, -- allows highlight groups to be overriden i.e. sets highlights as default
				numbers = "ordinal", 
				show_duplicate_prefix = false,
				separator_style = "slant",
				custom_filter = function(buf_number, buf_numbers)
					-- print(buf_numbers)
					local ft = vim.bo[buf_number].filetype
					-- Hide alpha, dashboard, and starter filetypes from bufferline
					if ft == "alpha" or ft == "dashboard" or ft == "starter" then
						return false
					end
					return true
				end
			},
		}
	end
}
