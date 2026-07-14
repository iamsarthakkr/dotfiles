---@diagnostic disable: missing-fields
return {
	{
		"github/copilot.vim",
		config = function()
			vim.g.copilot_no_tab_map = true
			vim.g.copilot_filetypes = {
				["*"] = false,
				markdown = true,
				text = true,
				help = true,
				helpfile = true,
			}

			vim.keymap.set("i", "<C-y>", "<cmd>copilot#Accept<CR", {
				expr = true,
				replace_keycodes = false,
			})
			vim.g.copilot_no_tab_map = true
		end,
	},
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		dependencies = {
			{ "github/copilot.vim" }, -- or zbirenbaum/copilot.lua
			{ "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
		},
		build = "make tiktoken", -- Only on MacOS or Linux
		opts = {},
		config = function()
			require("CopilotChat").setup({
				system_prompt = "COPILOT_INSTRUCTIONS",

				model = "gpt-4.1",
				agent = "copilot",
				context = nil,
				sticky = nil,

				temperature = 0.1,
				headless = false,
				stream = nil,
				callback = nil,
				remember_as_sticky = true,

				window = {
					layout = "float",
					width = 0.6,
					height = 0.8,
					-- Options below only apply to floating windows
					relative = "editor",
					border = "single",
					row = nil,
					col = nil,
					title = "Copilot Chat",
					footer = nil,
					zindex = 1,
				},

				show_help = true,
				highlight_selection = true,
				highlight_headers = true,
				references_display = "virtual",
				auto_follow_cursor = true,
				auto_insert_mode = false,
				insert_at_end = false,
				clear_chat_on_new_prompt = false,

				-- Static config starts here (can be configured only via setup function)

				debug = false,
				log_level = "info",
				proxy = nil,
				allow_insecure = false,

				chat_autocomplete = true,

				log_path = vim.fn.stdpath("state") .. "/CopilotChat.log",
				history_path = vim.fn.stdpath("data") .. "/copilotchat_history",

				question_header = "# User ",
				answer_header = "# Copilot ",
				error_header = "# Error ",
				separator = "───",

				-- default prompts
				-- see config/prompts.lua for implementation
				prompts = {
					Explain = {
						prompt = "Write an explanation for the selected code as paragraphs of text.",
						system_prompt = "COPILOT_EXPLAIN",
					},
					Review = {
						prompt = "Review the selected code.",
						system_prompt = "COPILOT_REVIEW",
					},
					Fix = {
						prompt = "There is a problem in this code. Identify the issues and rewrite the code with fixes. Explain what was wrong and how your changes address the problems.",
					},
					Optimize = {
						prompt = "Optimize the selected code to improve performance and readability. Explain your optimization strategy and the benefits of your changes.",
					},
					Docs = {
						prompt = "Please add documentation comments to the selected code.",
					},
					Tests = {
						prompt = "Please generate tests for my code.",
					},
					Commit = {
						prompt = "Write commit message for the change with commitizen convention. Keep the title under 50 characters and wrap message at 72 characters. Format as a gitcommit code block.",
						context = "git:staged",
					},
				},

				-- default mappings
				-- see config/mappings.lua for implementation
				mappings = {
					complete = {
						insert = "<Tab>",
					},
					close = {
						normal = "<C-c>",
						insert = "<C-c>",
					},
					reset = {
						normal = "<C-l>",
						insert = "<C-l>",
					},
					submit_prompt = {
						normal = "<CR>",
						insert = "<C-s>",
					},
					toggle_sticky = {
						normal = "grr",
					},
					clear_stickies = {
						normal = "grx",
					},
					accept_diff = {
						normal = "<C-y>",
						insert = "<C-y>",
					},
					jump_to_diff = {
						normal = "gj",
					},
					quickfix_answers = {
						normal = "gqa",
					},
					quickfix_diffs = {
						normal = "gqd",
					},
					yank_diff = {
						normal = "gy",
						register = '"', -- Default register to use for yanking
					},
					show_diff = {
						normal = "gd",
						full_diff = false, -- Show full diff instead of unified diff when showing diff window
					},
					show_info = {
						normal = "gi",
					},
					show_context = {
						normal = "gc",
					},
					show_help = {
						normal = "gh",
					},
				},
			})

			local keymap = vim.keymap

			keymap.set("n", "<leader>cc", ":CopilotChatToggle<CR>", { desc = "toggle copilot chat" })
		end,
	},
}
