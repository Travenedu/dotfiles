return {
  {
    -- Required for compatibility with legacy nvim-cmp sources (like cmp-sql)
    "saghen/blink.compat",
    version = "*",
    lazy = true,
    opts = {},
  },
  {
    "saghen/blink.cmp",
    version = "*",
    dependencies = {
      "rafamadriz/friendly-snippets",
      "moyiz/blink-emoji.nvim",
      "ray-x/cmp-sql",
    },
    lazy = false, -- Load early to provide LSP capabilities

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      -- KEYMAPS: 'default' uses:
      -- <C-space> to complete, <Tab>/<S-Tab> to select, <CR> to confirm
      keymap = {
        preset = "default",
        ["<C-z>"] = { "accept", "fallback" },
      },

      -- VISUALS: Icons and Nerd Font support
      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = "mono",
        kind_icons = {
          Text = "󰉿",
          Method = "󰊕",
          Function = "󰊕",
          Constructor = "󰒓",
          Field = "󰜢",
          Variable = "󰆦",
          Class = "󰌗",
          Interface = "󱡠",
          Module = "󰅩",
          Property = "󰜢",
          Unit = "󰪚",
          Value = "󰦨",
          Enum = "󰐠",
          Keyword = "󰻛",
          Snippet = "󱄽",
          Color = "󰏘",
          File = "󰈙",
          Reference = "󰬲",
          Folder = "󰉋",
          EnumMember = "󰐠",
          Constant = "󰏿",
          Struct = "󰙅",
          Event = "󱐋",
          Operator = "󰆕",
          TypeParameter = "󰉺",
        },
      },

      -- COMPLETION MENU
      completion = {
        -- Show ghost text (preview) while typing
        ghost_text = { enabled = true },
        
        -- Rounded borders for a modern look
        menu = { 
          border = "rounded",
          draw = {
            columns = {
              { "kind_icon", "label", gap = 1 },
              { "kind" },
            },
          },
        },
        
        -- Show documentation automatically when a menu item is selected
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 200,
          window = { border = "rounded" },
        },
      },

      -- SIGNATURE HELP (Shows function arguments as you type)
      signature = {
        enabled = true,
        window = { border = "rounded" },
      },

      -- SOURCES: Where the data comes from
      sources = {
        default = { "lsp", "path", "snippets", "buffer", "emoji", "sql" },
        providers = {
          emoji = {
            module = "blink-emoji",
            name = "Emoji",
            score_offset = 15,
            opts = { insert = true },
            should_show_items = function()
              return vim.tbl_contains({ "gitcommit", "markdown" }, vim.o.filetype)
            end,
          },
          sql = {
            name = "sql",
            module = "blink.compat.source",
            score_offset = -3,
            should_show_items = function()
              return vim.tbl_contains({ "sql", "mysql", "plsql" }, vim.o.filetype)
            end,
          },
        },
      },
    },
  },
}
