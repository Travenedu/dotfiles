return {
    {
      "leath-dub/snipe.nvim",
      keys = {
        { "gb", function() require("snipe").open_buffer_menu() end, desc = "Open Snipe buffer menu" },
      },
      config = function()
        local snipe = require("snipe")

        -- Setup
        snipe.setup()
 
        -- Optional: another keybind (if you want a leader-prefixed one)
        vim.keymap.set("n", "gb", snipe.open_buffer_menu, {desc = 'Open Snipe File Buffer'})
 
        -- UI customizations
        snipe.ui_select_menu = require("snipe.menu"):new { position = "center" }
        snipe.ui_select_menu:add_new_buffer_callback(function(m)
          vim.keymap.set("n", "<esc>", function()
            m:close()
          end, { nowait = true, buffer = m.buf })
        end)
 
        -- Override vim.ui.select
        vim.ui.select = snipe.ui_select
      end,
    }
}
