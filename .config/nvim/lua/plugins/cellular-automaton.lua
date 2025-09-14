return {
  {
    "eandrju/cellular-automaton.nvim",
    config = function()
      -- Set keymap to start the animation
      vim.keymap.set("n", "<leader>fml", "<cmd>CellularAutomaton make_it_rain<CR>",
      {desc = "Make it rain 🌧️", })
    end,
  }
}


