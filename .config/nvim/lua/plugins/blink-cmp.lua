return {
    {
        "saghen/blink.compat",
        version = "*",
        lazy = true,
        opts = {},
    },
    {
        "saghen/blink.cmp",
        dependencies = {
            "rafamadriz/friendly-snippets",
            "moyiz/blink-emoji.nvim",
            "ray-x/cmp-sql",
        },

        version = "1.*",

        ---@module 'blink.cmp'
        ---@type blink.cmp.Config
        opts = {
            keymap = {
                preset = "default",
                ["<C-Z>"] = { "accept", "fallback" },
            },

            appearance = {
                nerd_font_variant = "mono",
            },

            completion = { documentation = { auto_show = true } },
            signature = { enabled = true },

            sources = {
                default = { "lsp", "path", "snippets", "buffer", "emoji", "sql" },
                providers = {
                    emoji = {
                        module = "blink-emoji",
                        name = "Emoji",
                        score_offset = 15, -- Tune by preference
                        opts = { insert = true }, -- Insert emoji (default) or complete its name
                        should_show_items = function()
                            return vim.tbl_contains(
                                -- Enable emoji completion only for git commits and markdown.
                                -- By default, enabled for all file-types.
                                { "gitcommit", "markdown" },
                                vim.o.filetype
                            )
                        end,
                    },
                    sql = {
                        name = "sql",
                        module = "blink.compat.source",

                        score_offset = -3,

                        opts = {},
                        should_show_items = function()
                            return vim.tbl_contains(
                                { "sql" },
                                vim.o.filetype
                            )
                        end,
                    },
                },
            },
            fuzzy = { implementation = "prefer_rust_with_warning" },
        },
        opts_extend = { "sources.default" },
    },
}
