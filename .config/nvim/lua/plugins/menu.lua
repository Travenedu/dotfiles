
return {
  {
    "nvzone/volt",
    lazy = true
  },
  {
    "nvzone/menu",
    lazy = true,
    config = function()
      local menu = require("menu")

      -- Keyboard users
      vim.keymap.set("n", "<C-t>", function()
        menu.open("default")
      end, {})

      -- Mouse users + nvimtree users
      vim.keymap.set({ "n", "v" }, "<RightMouse>", function()
        require('menu.utils').delete_old_menus()

        vim.cmd.exec '"normal! \\<RightMouse>"'

        local buf = vim.api.nvim_win_get_buf(vim.fn.getmousepos().winid)
        local options = vim.bo[buf].ft == "NvimTree" and "nvimtree" or "default"

        menu.open(options, { mouse = true })
      end, {})
    end
  }
}

