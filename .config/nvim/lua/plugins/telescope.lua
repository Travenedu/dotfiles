return {
  {
    "nvim-telescope/telescope-ui-select.nvim",
  },
  {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
  },
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local telescope = require("telescope")

      telescope.setup({
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown({}),
          },
          file_browser = {
            hijack_netrw = true,
            mappings = {
              ["i"] = {
                -- custom insert mode mappings
              },
              ["n"] = {
                -- custom normal mode mappings
              },
            },
          },
        },
      })

      -- Load extensions
      telescope.load_extension("ui-select")
      telescope.load_extension("file_browser")

      -- Keymaps
      local builtin = require("telescope.builtin")
      vim.keymap.set("n", "<space>fE", ":Telescope file_browser<CR>")
      vim.keymap.set("n", "<space>fb", ":Telescope file_browser path=%:p:h select_buffer=true<CR>")
    end,
  },
}

