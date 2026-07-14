return {
	"neovim/nvim-lspconfig",
	lazy = false,

	dependencies = {
		"saghen/blink.cmp",
		{ "antosha417/nvim-lsp-file-operations", config = true },

		-- neodev.nvim is archived/deprecated for newer Lua LS setups.
		-- Consider replacing it with folke/lazydev.nvim.
		{ "folke/neodev.nvim", opts = {} },
	},

	config = function()
		vim.diagnostic.config({
			virtual_text = {
				prefix = function(diagnostic)
					local icons = {
						[vim.diagnostic.severity.ERROR] = "",
						[vim.diagnostic.severity.WARN] = "",
						[vim.diagnostic.severity.INFO] = "",
						[vim.diagnostic.severity.HINT] = "󰌵",
					}

					return icons[diagnostic.severity] or ""
				end,

				virt_text_pos = "eol_right_align",
				source = "if_many",
			},

			signs = true,
			underline = true,
			update_in_insert = false,
			severity_sort = true,
		})

		local capabilities = require("blink.cmp").get_lsp_capabilities()

		-- Apply Blink capabilities to every configured server.
		vim.lsp.config("*", {
			capabilities = capabilities,
		})

		vim.lsp.config("lua_ls", {
			settings = {
				Lua = {
					runtime = {
						version = "LuaJIT",
					},

					diagnostics = {
						globals = {
							"vim",
						},
					},

					workspace = {
						checkThirdParty = false,
						library = {
							vim.env.VIMRUNTIME,
						},
					},

					telemetry = {
						enable = false,
					},

					format = {
						enable = false,
					},
				},
			},
		})

		vim.lsp.config("ts_ls", {
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

		vim.lsp.enable({
			"ts_ls",
			"lua_ls",
			"tailwindcss",
			"clangd",
		})

		local group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true })

		vim.api.nvim_create_autocmd("LspAttach", {
			group = group,

			callback = function(ev)
				local builtin = require("telescope.builtin")

				local function map(mode, lhs, rhs, desc)
					vim.keymap.set(mode, lhs, rhs, {
						buffer = ev.buf,
						silent = true,
						desc = desc,
					})
				end

				vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

				map("n", "gd", builtin.lsp_definitions, "Show LSP definitions")
				map("n", "gr", builtin.lsp_references, "Show LSP references")
				map("n", "gD", vim.lsp.buf.declaration, "Show LSP declaration")
				map("n", "gT", vim.lsp.buf.type_definition, "Show LSP type definition")

				map("n", "<leader>gf", function()
					vim.lsp.buf.format({
						async = true,
					})
				end, "Format file")

				map("n", "<space>wd", builtin.lsp_document_symbols, "Show document symbols")

				map({ "n", "x" }, "<leader>ca", function()
					require("tiny-code-action").code_action()
				end, "See available code actions")

				map("n", "<leader>cr", vim.lsp.buf.rename, "Smart rename")

				map("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", "Show buffer diagnostics")

				map("n", "<leader>d", vim.diagnostic.open_float, "Show line diagnostics")

				map("n", "K", vim.lsp.buf.hover, "Show documentation")
			end,
		})
	end,
}
