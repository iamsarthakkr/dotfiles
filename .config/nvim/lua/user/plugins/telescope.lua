return {
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
			"nvim-tree/nvim-web-devicons",
			"nvim-telescope/telescope-ui-select.nvim",
		},
		config = function()
			local telescope = require("telescope")
			local actions = require("telescope.actions")

			telescope.setup({
				defaults = {
					path_display = { "smart" },
					mappings = {
						i = {
							["<C-k>"] = actions.move_selection_previous, -- move to prev result
							["<C-j>"] = actions.move_selection_next, -- move to next result
							["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
							["<C-CR>"] = actions.select_tab,
						},
						n = {
							["<C-CR>"] = actions.select_tab,
						},
					},
				},
			})
			pcall(require("telescope").load_extension, "fzf")

			-- set keymaps
			local keymap = vim.keymap -- for conciseness

			keymap.set("n", "<leader>ff", function()
				local opts = require("telescope.themes").get_ivy({
					cwd = vim.fn.getcwd(),
				})
				require("telescope.builtin").find_files(opts)
			end, { desc = "Fuzzy find files in cwd" })

			keymap.set("n", "<leader>fb", function()
				local opts = require("telescope.themes").get_ivy({})
				require("telescope.builtin").buffers(opts)
			end, { desc = "Search open buffers" })

			keymap.set("n", "<leader>fc", function()
				local opts = require("telescope.themes").get_ivy({ cwd = vim.fn.stdpath("config") })
				require("telescope.builtin").find_files(opts)
			end, { desc = "Fuzzy find files in config dir" })

			keymap.set("n", "<leader>fr", function()
				local opts = require("telescope.themes").get_ivy()
				require("telescope.builtin").live_grep(opts)
			end, { desc = "Fuzzy find recent files" })

			keymap.set("n", "<leader>fs", function()
				local opts = require("telescope.themes").get_dropdown()
				require("telescope.builtin").current_buffer_fuzzy_find(opts)
			end, { desc = "Find string in current buffer" })

			keymap.set("n", "<leader>fa", function()
				local opts = require("telescope.themes").get_dropdown()
				require("telescope.builtin").live_grep(opts)
			end, { desc = "Find string in cwd" })

			keymap.set("n", "<leader>f.", function()
				local opts = require("telescope.themes").get_dropdown()
				require("telescope.builtin").grep_string(opts)
			end, { desc = "Find string under cursor in cwd" })
		end,
	},
	{
		"rachartier/tiny-code-action.nvim",
		dependencies = {
			{ "nvim-lua/plenary.nvim" },
		},
		event = "LspAttach",
		opts = {
			backend = "vim",
			picker = "telescope",
			backend_opts = {
				delta = {
					header_lines_to_remove = 4,
					args = {
						"--line-numbers",
					},
				},
				difftastic = {
					header_lines_to_remove = 1,
					args = {
						"--color=always",
						"--display=inline",
						"--syntax-highlight=on",
					},
				},
				diffsofancy = {
					header_lines_to_remove = 4,
				},
			},
			signs = {
				quickfix = { "", { link = "DiagnosticWarning" } },
				others = { "", { link = "DiagnosticWarning" } },
				refactor = { "", { link = "DiagnosticInfo" } },
				["refactor.move"] = { "󰪹", { link = "DiagnosticInfo" } },
				["refactor.extract"] = { "", { link = "DiagnosticError" } },
				["source.organizeImports"] = { "", { link = "DiagnosticWarning" } },
				["source.fixAll"] = { "󰃢", { link = "DiagnosticError" } },
				["source"] = { "", { link = "DiagnosticError" } },
				["rename"] = { "󰑕", { link = "DiagnosticWarning" } },
				["codeAction"] = { "", { link = "DiagnosticWarning" } },
			},
		},
	},
}
