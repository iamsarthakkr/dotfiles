return {
    "nvimtools/none-ls.nvim",
    dependencies = {
        "nvimtools/none-ls-extras.nvim",
    },
    config = function()
        local null_ls = require("null-ls")

        null_ls.setup({
            sources = {
                null_ls.builtins.formatting.stylua,
                null_ls.builtins.formatting.prettier,
                null_ls.builtins.formatting.clang_format.with({
                    extra_args = { "--style=file" },
                }),
                require("none-ls.diagnostics.eslint").with({
                    condition = function(utils)
                        -- only enable if there's an ESLint config file
                        return utils.root_has_file({
                            ".eslintrc.js",
                            ".eslintrc.cjs",
                            ".eslintrc.mjs",
                            ".eslintrc.json",
                            "eslint.config.js",
                            "eslint.config.mjs",
                        })
                    end,
                }),
            },
        })

        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("my.lsp", {}),
            callback = function(args)
                local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

                if
                    not client:supports_method("textDocument/willSaveWaitUntil")
                    and client:supports_method("textDocument/formatting")
                then
                    vim.api.nvim_create_autocmd("BufWritePre", {
                        group = vim.api.nvim_create_augroup("my.lsp", { clear = false }),
                        buffer = args.buf,
                        callback = function()
                            vim.lsp.buf.format({ bufnr = args.buf, id = client.id, timeout_ms = 1000 })
                        end,
                    })
                end
            end,
        })
    end,
}
