return {
	"neovim/nvim-lspconfig",
	lazy = false,
	dependencies = {
		"saghen/blink.cmp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
		{ "folke/neodev.nvim", opts = {} },
	},
	config = function()
		vim.diagnostic.enable = true
		vim.diagnostic.config({
			virtual_text = {
				prefix = function(diagnostic)
					local icons = {
						[vim.diagnostic.severity.ERROR] = "", -- Error
						[vim.diagnostic.severity.WARN] = "", -- Warning
						[vim.diagnostic.severity.INFO] = "", -- Info
						[vim.diagnostic.severity.HINT] = "󰌵", -- Hint
					}
					return icons[diagnostic.severity] or ""
				end,
				virt_text_pos = "eol_right_align",
				source = "if_many", -- show source if multiple
			},
			signs = true,
			underline = true,
			update_in_insert = false,
			severity_sort = true,
			current_line = true,
		})
		local lspconfig = require("lspconfig")
		local capabilities = nil
		if pcall(require, "cmp_nvim_lsp") then
			capabilities = require("blink.cmp").get_lsp_capabilities()
		end

		lspconfig.lua_ls.setup({ capabilities = capabilities })
		lspconfig.ts_ls.setup({
			capabilities = capabilities,
			settings = {
				typescript = {
					format = {
						indentSize = 4,
						tabSize = 4,
						convertTabsToSpaces = true,
					},
				},
				javascript = {
					format = {
						indentSize = 4,
						tabSize = 4,
						convertTabsToSpaces = true,
					},
				},
			},
		})
		lspconfig.clangd.setup({ capabilities = capabilities })

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
			callback = function(ev)
				-- Buffer local mappings.
				-- See `:help vim.lsp.*` for documentation on any of the below functions
				local opts = { buffer = ev.buf, silent = true }
				local keymap = vim.keymap
				local builtin = require("telescope.builtin")

				-- set keybinds
				vim.opt_local.omnifunc = "v:lua.vim.lsp.omnifunc"

				opts.desc = "Show LSP definitions"
				vim.keymap.set("n", "gd", builtin.lsp_definitions, opts)

				opts.desc = "Show LSP references"
				vim.keymap.set("n", "gr", builtin.lsp_references, opts)

				opts.desc = "Show LSP declaration"
				vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

				opts.desc = "Show LSP type definition"
				vim.keymap.set("n", "gT", vim.lsp.buf.type_definition, opts)

				opts.desc = "Format file"
				vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, opts)

				opts.desc = "Show LSP document symbols"
				vim.keymap.set("n", "<space>wd", builtin.lsp_document_symbols, opts)

				opts.desc = "See available code actions"
				vim.keymap.set({ "n", "x" }, "<leader>ca", function()
					require("tiny-code-action").code_action(opts)
				end, opts)

				opts.desc = "Smart rename"
				keymap.set("n", "<leader>cr", vim.lsp.buf.rename, opts) -- smart rename

				opts.desc = "Show buffer diagnostics"
				keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)

				opts.desc = "Show line diagnostics"
				keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)

				opts.desc = "Show documentation for what is under cursor"
				keymap.set("n", "K", vim.lsp.buf.hover, opts)
			end,
		})
	end,
}
