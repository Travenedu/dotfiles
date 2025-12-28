return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  keys = {
    {
      "<leader>,,",
      function()
        require("conform").format({ async = true, lsp_fallback = true })
        vim.notify("File formatted 󰂞 ", vim.log.levels.INFO)
      end,
      mode = "n",
      desc = "Format file",
    },
    {
      "<leader>Tf",
      function()
        if vim.g.disable_autoformat then
          vim.g.disable_autoformat = false
          vim.notify("Autoformat Enabled ")
        else
          vim.g.disable_autoformat = true
          vim.notify("Autoformat Disabled ")
        end
      end,
      mode = "n",
      desc = "[T]oggle Auto[f]ormat",
    },
  },
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      go = { "goimports", "gofmt" },
      python = { "isort", "black" },
      bash = { "shfmt" },
    },
    format_on_save = function(bufnr)
      -- Check if global or buffer-local autoformat is disabled
      if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
        return
      end
      return {
        timeout_ms = 1000, -- Higher timeout to avoid the Go timeout warning
        lsp_fallback = true,
      }
    end,
  },
}
