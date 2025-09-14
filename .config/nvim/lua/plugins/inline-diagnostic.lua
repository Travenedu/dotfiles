return {
  {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "VeryLazy", -- Or `LspAttach`
    priority = 1000,    -- needs to be loaded in first
    config = function()
      -- Default configuration
      require("tiny-inline-diagnostic").setup({
        -- Style preset for diagnostic messages
        -- Available options:
        -- "modern", "classic", "minimal", "powerline",
        -- "ghost", "simple", "nonerdfont", "amongus"
        preset = "powerline",

        transparent_bg = false,
        transparent_cursorline = false,

        hi = {
          error = "DiagnosticError",
          warn = "DiagnosticWarn",
          info = "DiagnosticInfo",
          hint = "DiagnosticHint",
          arrow = "NonText",       -- Highlight group for diagnostic arrows

          -- Background color for diagnostics
          background = "CursorLine",

          -- Color blending option for the diagnostic background
          mixing_color = "None",
        },

        options = {
          -- Display the source of the diagnostic (e.g., basedpyright, vsserver, lua_ls etc.)
          show_source = {
            enabled = false,
            if_many = false,
          },

          -- Use icons defined in the diagnostic configuration
          use_icons_from_diagnostic = false,

          -- Set the arrow icon to the same color as the first diagnostic severity
          set_arrow_to_diag_color = false,

          add_messages = true,

          throttle = 20,

          -- Minimum message length before wrapping to a new line
          softwrap = 30,

          multilines = {
            -- Enable multiline diagnostic messages
            enabled = false,

            -- Always show messages on all lines for multiline diagnostics
            always_show = false,
          },

          -- Display all diagnostic messages on the cursor line
          show_all_diags_on_cursorline = false,

          -- Enable diagnostics in Insert mode
          -- If enabled, it is better to set the `throttle` option to 0 to avoid visual artifacts
          enable_on_insert = false,

          -- Enable diagnostics in Select mode (e.g when auto inserting with Blink)
          enable_on_select = false,

          overflow = {
            mode = "wrap",

            padding = 0,
          },

          -- Configuration for breaking long messages into separate lines
          break_line = {
            -- Enable the feature to break messages after a specific length
            enabled = false,

            -- Number of characters after which to break the line
            after = 30,
          },

          -- Custom format function for diagnostic messages
          -- Example:
          -- format = function(diagnostic)
          --     return diagnostic.message .. " [" .. diagnostic.source .. "]"
          -- end
          format = nil,


          virt_texts = {
            -- Priority for virtual text display
            priority = 2048,
          },

          severity = {
            vim.diagnostic.severity.ERROR,
            vim.diagnostic.severity.WARN,
            vim.diagnostic.severity.INFO,
            vim.diagnostic.severity.HINT,
          },

          overwrite_events = nil,
        },
        disabled_ft = {} -- List of filetypes to disable the plugin
      })

      vim.diagnostic.config({ virtual_text = false })
    end
  }
}
