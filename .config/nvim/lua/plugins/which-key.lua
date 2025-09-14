return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    require("which-key").add({
      { "ma", mode = "n", desc = "Harpoon add" },
      { "M", mode = "n", desc = "Harpoon menu" },
      { "S", mode = "v", desc = "Add surround visual" },
      { "<leader><tab>", group = "Tabs" },
      { "<leader>w", group = "Wins" },
      { "<leader>y", group = "Yank" },
      { "<leader>F", group = "File" },
      { "<leader>f", group = "Find" },
      { "<leader>l", group = "LSP" },
      { "<leader>s", group = "Search" },
      { "<leader>b", group = "Buffers" },
      { "<leader>g", group = "Git" },
      { "<leader>h", group = "Harpoon" },
      { "<leader>t", group = "Toggles" },
      { "<leader>n", group = "Notifications" },
      { "<leader>m", group = "Static Analysis" },
      { "<leader>C", group = "Configurations" },
      { "<leader>A", group = "Applications"},
    })
  end,
  opts = {
    preset = "helix",
    plugins = {
      presets = {
        operators = true,
			  motions = true,
			  text_objects = true,
			  windows = true,
			  nav = true,
			  z = true,
			  g = true,
      },
    },
    win = {
      height = { max = 20 },
      border = "single",
      padding = { 0, 1 },
    },
    keys = {
      scroll_down = "<c-f>",
      scroll_up = "<c-u>",
    },
    replace = {
      key = {
        { "<BS>", "ret" },
        { "<Space>", "spc" },
        { "<S%-Tab>", "stab" },
      },
    },
    icons = {
      rules = false,
      separator = "→",
    },
    show_help = false,
  },
}
