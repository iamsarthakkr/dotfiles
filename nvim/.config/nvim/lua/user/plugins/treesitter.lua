---@diagnostic disable: missing-fields
return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	event = { "BufReadPre", "BufNewFile" },
	build = ":TSUpdate",
	dependencies = {
		"windwp/nvim-ts-autotag",
		"nvim-treesitter/nvim-treesitter-textobjects",
	},
	config = function()
		require("nvim-treesitter").install({
			"json",
			"typescript",
			"javascript",
			"tsx",
			"html",
			"css",
			"cpp",
			"c",
			"lua",
			"vim",
			"vimdoc",
			"query",
			"markdown",
			"markdown_inline",
		})

		-- On the "main" branch rewrite, highlight/indent are no longer automatic —
		-- each buffer has to opt in for its filetype.
		vim.api.nvim_create_autocmd("FileType", {
			callback = function(args)
				local max_filesize = 100 * 1024 -- 100 KB
				local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(args.buf))
				if ok and stats and stats.size > max_filesize then
					return
				end

				if pcall(vim.treesitter.start) then
					vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				end
			end,
		})

		-- incremental_selection was dropped from nvim-treesitter core; Neovim 0.12
		-- ships equivalent default mappings (visual mode: an/in, ]n/[n, ]N/[N)

		require("nvim-treesitter-textobjects").setup({
			select = {
				lookahead = true,
			},
		})

		local select = require("nvim-treesitter-textobjects.select")
		local map = vim.keymap.set
		map({ "x", "o" }, "af", function()
			select.select_textobject("@function.outer", "textobjects")
		end)
		map({ "x", "o" }, "if", function()
			select.select_textobject("@function.inner", "textobjects")
		end)
		map({ "x", "o" }, "ac", function()
			select.select_textobject("@class.outer", "textobjects")
		end)
		map({ "x", "o" }, "ic", function()
			select.select_textobject("@class.inner", "textobjects")
		end)

		require("nvim-ts-autotag").setup({
			opts = {
				-- Defaults
				enable_close = true, -- Auto close tags
				enable_rename = true, -- Auto rename pairs of tags
				enable_close_on_slash = false, -- Auto close on trailing </
			},
			-- Also override individual filetype configs, these take priority.
			-- Empty by default, useful if one of the "opts" global settings
			-- doesn't work well in a specific filetype
			per_filetype = {
				["html"] = {
					enable_close = false,
				},
			},
		})
	end,
}
