return {
  {
    "catppuccin/nvim",
    lazy = false,
    name = "catppuccin",
    priority = 1000,
    config = function()
        vim.cmd.colorscheme "catppuccin"
    end
  },
  {
  "rockyzhang24/arctic.nvim",
  dependencies = { "rktjmp/lush.nvim" },
  name = "arctic",
  branch = "main",
  config = function()
    vim.cmd("colorscheme arctic")
  end
  },
}
