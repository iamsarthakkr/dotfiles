return {
    {
        "saghen/blink.cmp",
        -- optional: provides snippets for the snippet source
        dependencies = {
            "rafamadriz/friendly-snippets",
        },
        version = "1.*",
        opts = {
            keymap = {
                preset = "default",
                ["<C-K>"] = { "select_prev", "fallback" },
                ["<C-J>"] = { "select_next", "fallback" },
                ["<CR>"] = { "select_and_accept", "fallback" },
            },
            appearance = {
                nerd_font_variant = "mono",
            },
            signature = { enabled = true },
            completion = { documentation = { auto_show = true, auto_show_delay_ms = 500 } },
            snippets = { preset = "luasnip" },
            sources = {
                default = { "lsp", "path", "snippets", "buffer" },
            },
            fuzzy = { implementation = "prefer_rust_with_warning" },
        },
        opts_extend = { "sources.default" },
    },
    {
        "L3MON4D3/LuaSnip",
        version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
        build = "make install_jsregexp",
        config = function()
            require("luasnip.loaders.from_vscode").lazy_load()
            require("luasnip.loaders.from_snipmate").lazy_load({ paths = { "~/.config/nvim/snippets" } })
        end,
    },
}
