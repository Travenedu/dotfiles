return {
  {
    "nvzone/timerly",
    dependencies = "nvzone/volt",
    cmd = "TimerlyToggle",
    config = function()
      require("timerly").setup({
        auto_start = false,
        show_seconds = true,
      })

      vim.keymap.set("n", "<leader>tt", "<cmd>TimerlyToggle<CR>", { desc = "Toggle Timerly" })
    end
  }
}

