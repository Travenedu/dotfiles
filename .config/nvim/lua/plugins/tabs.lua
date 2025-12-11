return {
  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      vim.opt.termguicolors = true

      require("bufferline").setup({
        options = {
          style = "slant",
          mode = "buffers",
          offsets = {
            {
              filetype = "snacks_layout_box",
              text = "",
              text_align = "left",
              separator = true,
            },
          },
          custom_filter = function(buf_number)
            local buftype = vim.api.nvim_get_option_value("buftype", { buf = buf_number })
            local filetype = vim.api.nvim_get_option_value("filetype", { buf = buf_number })

            -- Exclude buffers that are terminals (filetype='terminal' or buftype='terminal')
            -- We check both 'buftype' and 'filetype' for maximum compatibility (e.g., with toggleterm)
            if buftype == "terminal" or filetype == "terminal" or filetype == "toggleterm" then
              return false -- Return false to exclude the buffer
            end

            return true -- Return true to display the buffer
          end,
          groups = {
            options = {
              toggle_hidden_on_enter = true,
            },
            items = {
              {
                name = "Docs",
                -- highlight = { undercurl = false, sp = "green" },
                auto_close = false, -- whether or not close this group if it doesn't contain the current buffer
                matcher = function(buf)
                  return buf.path:match("%.md") or buf.path:match("%.txt")
                end,
                separator = { -- Optional
                  style = require("bufferline.groups").separator.tab,
                },
              },
              {
                name = "Tests", -- Mandatory
                highlight = { underline = false, sp = "blue" }, -- Optional
                priority = 2, -- determines where it will appear relative to other groups (Optional)
                icon = " ", -- Optional
                matcher = function(buf) -- Mandatory
                  return buf.path:match("%_test") or buf.path:match("%_spec")
                end,
              },
              {
                name = "Headers", -- Mandatory
                highlight = { underline = false, sp = "blue" }, -- Optional
                priority = 2, -- determines where it will appear relative to other groups (Optional)
                icon = " ", -- Optional
                matcher = function(buf) -- Mandatory
                  return buf.path:match("%.h")
                end,
              },
              -- 5. Pinning
              -- This creates a specific group for pinned buffers at the start
              require("bufferline.groups").builtin.pinned:with({ icon = "" }),
            },
          },

          -- Visual Tweaks for better clarity
          separator_style = "slant",
          indicator = {
            style = "icon",
            icon = "▎",
          },
        },
      })
    end,
  },
}
