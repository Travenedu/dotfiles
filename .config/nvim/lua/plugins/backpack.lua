return {
  {
    'mitch1000/backpack.nvim',
    config = function ()
      require('backpack').setup({
      undercurl = false,
      commentStyle = { italic = true },
      compile = false,
      functionStyle = {},
      keywordStyle = { bold = true },
      statementStyle = { bold = true },
      returnStyle = { italic = false, bold = true },
      typeStyle = {},
      transparent = false,
      dimInactive = false,
      terminalColors = true,
      colors = { theme = { dark = {}, light = {} }, palette = {} },
      contrast = "medium", -- medium, high, extreme
      overrides = function()
          return {}
      end,
    })
    end
  },
}
