return {
  {
    "echasnovski/mini.nvim",
    version = false,
    config = function()
      require("mini.pairs").setup()
      require("mini.surround").setup()
      require("mini.move").setup()
      require("mini.trailspace").setup()
    end,
  },
}
