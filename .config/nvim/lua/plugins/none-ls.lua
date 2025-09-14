return {
  "nvimtools/none-ls.nvim",
  config = function()
    local null_ls = require("null-ls")

    null_ls.setup({
      sources = {
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.prettier,
        null_ls.builtins.formatting.black,
        null_ls.builtins.formatting.isort,
        null_ls.builtins.completion.spell,
        -- null_ls.builtins.diagnostics.eslint_d,
      },
    })

    vim.keymap.set("n", "<leader>mm", function()
      vim.lsp.buf.format()
      vim.notify("File formatted 🔔")
    end, { desc = "Format file" })
  end,
}
