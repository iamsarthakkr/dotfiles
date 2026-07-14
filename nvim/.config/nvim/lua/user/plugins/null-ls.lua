return {
	"nvimtools/none-ls.nvim",

	dependencies = {
		"nvimtools/none-ls-extras.nvim",
	},

	config = function()
		local null_ls = require("null-ls")

		local format_group = vim.api.nvim_create_augroup("NoneLsFormatting", { clear = true })

		null_ls.setup({
			sources = {
				null_ls.builtins.formatting.stylua,

				null_ls.builtins.formatting.prettier,

				null_ls.builtins.formatting.clang_format.with({
					extra_args = { "--style=file" },
				}),

				require("none-ls.diagnostics.eslint").with({
					condition = function(utils)
						return utils.root_has_file({
							-- Legacy ESLint configuration
							".eslintrc",
							".eslintrc.js",
							".eslintrc.cjs",
							".eslintrc.json",

							-- Flat ESLint configuration
							"eslint.config.js",
							"eslint.config.cjs",
							"eslint.config.mjs",
						})
					end,
				}),
			},

			on_attach = function(client, bufnr)
				if not client:supports_method("textDocument/formatting") then
					return
				end

				-- Prevent duplicate autocmds if null-ls reattaches.
				vim.api.nvim_clear_autocmds({
					group = format_group,
					buffer = bufnr,
				})

				vim.api.nvim_create_autocmd("BufWritePre", {
					group = format_group,
					buffer = bufnr,

					callback = function()
						vim.lsp.buf.format({
							bufnr = bufnr,
							async = false,
							timeout_ms = 3000,

							-- Never let ts_ls, clangd, lua_ls, etc.
							-- compete with none-ls during format-on-save.
							filter = function(format_client)
								return format_client.name == "null-ls"
							end,
						})
					end,
				})
			end,
		})
	end,
}
