return {
  {
    "bngarren/checkmate.nvim",
    ft = "markdown",
    opts = {
    files = { "*.md" }, -- any .md file (instead of defaults)
  },
    config = function()
      require("checkmate").setup({
        spellcheck = true,
        lint_on_save = true,
      })

      -- Example keymap to run Checkmate manually
      vim.keymap.set("n", "<leader>cm", "<cmd>Checkmate<CR>", { desc = "Run Checkmate" })
    end
  }
}

