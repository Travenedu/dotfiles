return {
  {
    "nvzone/typr",
    dependencies = "nvzone/volt",
    cmd = { "Typr", "TyprStats" },
    config = function()
      require("typr").setup({
        theme = "default",
        auto_save = true,
      })

      -- Optional: keymap to start Typr
      vim.keymap.set("n", "<leader>At", "<cmd>Typr<CR>", { desc = "Start Typr" })
    end
  }
}

