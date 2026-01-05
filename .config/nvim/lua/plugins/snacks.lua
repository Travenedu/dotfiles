return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      bigfile      = { enabled = true },
      explorer     = { enabled = true },
      indent       = { enabled = true },
      input        = { enabled = true },
      lazygit      = { enabled = true },
      notifier     = { enabled = true, timeout = 5000, },
      picker       = { enabled = true,
                       colorschemes = {
                        ignore_builtins = true,
                      }
                    },
      quickfile    = { enabled = true },
      scroll       = { enabled = true },
      statuscolumn = { enabled = true },
      scratch      = { enabled = true },
      styles       = {
        notification = { wo = { wrap = true } } }    -- Wrap notifications
    },
    keys = {
      -- Top Pickers & Explorer
      { "<leader><space>", function() Snacks.picker.smart() end,                                   desc = "Smart Find Files" },
      { "<leader>e",       function() Snacks.explorer() end,                                       desc = "File Explorer" },
      -- find
      { "<leader>fb",      function() Snacks.picker.buffers() end,                                 desc = "Buffers" },
      { "<leader>fc",      function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "Find Config File" },
      { "<leader>ff",      function() Snacks.picker.files() end,                                   desc = "Find Files" },
      -- Grep
      { "<leader>sb",      function() Snacks.picker.grep_buffers() end,                            desc = "Grep Open Buffers" },
      { "<leader>sg",      function() Snacks.picker.grep() end,                                    desc = "Grep" },
      { "<leader>sw",      function() Snacks.picker.grep_word() end,                               desc = "Visual selection or word", mode = { "n", "x" } },
      -- search
      { '<leader>s"',      function() Snacks.picker.registers() end,                               desc = "Registers" },
      { "<leader>sl",      function() Snacks.picker.lines() end,                                   desc = "Search Lines" },
      { "<leader>sd",      function() Snacks.picker.diagnostics_buffer() end,                      desc = "Buffer Diagnostics" },
      { "<leader>sc",      function() Snacks.picker.commands() end,                                desc = "Search Commands" },
      { "<leader>sh",      function() Snacks.picker.help({ layout = { position = "right" }}) end,                                    desc = "Help Pages" },
      { "<leader>si",      function() Snacks.picker.icons() end,                                   desc = "Icons" },
      { "<leader>sk",      function() Snacks.picker.keymaps() end,                                 desc = "Keymaps" },
      { "<leader>sm",      function() Snacks.picker.marks() end,                                   desc = "Marks" },
      { "<leader>sM",      function() Snacks.picker.man() end,                                     desc = "Man Pages" },
      { "<leader>sq",      function() Snacks.picker.qflist() end,                                  desc = "Quickfix List" },
      { "<leader>su",      function() Snacks.picker.undo() end,                                    desc = "Undo History" },
      -- Buffers
      { "<leader>bb",      function() Snacks.scratch() end,                                        desc = "Open Scratch Buffer" },
      { "<leader>bs",      function() Snacks.scratch.select() end,                                 desc = "Select Scratch Buffer" },
      -- LSP
      { "gd", function() Snacks.picker.lsp_definitions() end, desc = "Goto Definition" },
      { "gD", function() Snacks.picker.lsp_declarations() end, desc = "Goto Declaration" },
      { "gr", function() Snacks.picker.lsp_references() end, nowait = true, desc = "References" },
      { "gI", function() Snacks.picker.lsp_implementations() end, desc = "Goto Implementation" },
      { "gy", function() Snacks.picker.lsp_type_definitions() end, desc = "Goto T[y]pe Definition" },
      { "gai", function() Snacks.picker.lsp_incoming_calls() end, desc = "C[a]lls Incoming" },
      { "gao", function() Snacks.picker.lsp_outgoing_calls() end, desc = "C[a]lls Outgoing" },
      { "<leader>sS", function() Snacks.picker.lsp_workspace_symbols() end, desc = "LSP Workspace Symbols" },
      -- Other
      { "<leader>Tz",      function() Snacks.zen() end,                                            desc = "Toggle Zen Mode" },
      { "<leader>CC",      function() Snacks.picker.colorschemes() end,                            desc = "Colorschemes" },
      { "<leader>TZ",      function() Snacks.zen.zoom() end,                                       desc = "Toggle Zoom" },
      { "<leader>n",       function() Snacks.notifier.show_history() end,                          desc = "Notification History" },
      { "<leader>bd",      function() Snacks.bufdelete() end,                                      desc = "Delete Buffer" },
      { "<leader>GB",      function() Snacks.gitbrowse() end,                                      desc = "Git Browse",               mode = { "n", "v" } },
      { "]]",              function() Snacks.words.jump(vim.v.count1) end,                         desc = "Next Reference",           mode = { "n", "t" } },
      { "[[",              function() Snacks.words.jump(-vim.v.count1) end,                        desc = "Prev Reference",           mode = { "n", "t" } },
    },
    init = function()
      vim.api.nvim_create_autocmd("User", {
        pattern = "VeryLazy",
        callback = function()
          -- Setup some globals for debugging (lazy-loaded)
          _G.dd = function(...)
            Snacks.debug.inspect(...)
          end
          _G.bt = function()
            Snacks.debug.backtrace()
          end
          vim.print = _G.dd       -- Override print to use snacks for `:=` command

          -- Create some toggle mappings
          Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>Ts")
          Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>Tw")
          Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>TL")
          Snacks.toggle.diagnostics():map("<leader>Td")
          Snacks.toggle.line_number():map("<leader>Tl")
          Snacks.toggle.option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }):map(
          "<leader>Tc")
          Snacks.toggle.treesitter():map("<leader>TT")
          Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map("<leader>Tb")
          Snacks.toggle.inlay_hints():map("<leader>Th")
          Snacks.toggle.indent():map("<leader>Tg")
        end,
      })
    end,
  }
}
