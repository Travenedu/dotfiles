return {
  "folke/persistence.nvim",
  event = "BufReadPost", -- Start persistence when a buffer is read
  module = "persistence",
  config = function()
    require("persistence").setup({
      -- Optional: Configure the directory where sessions are saved
      dir = vim.fn.stdpath("data") .. "/sessions/",
      -- Optional: List of file types you DON'T want to save sessions for
      exclude_ft = { "gitcommit", "gitrebase", "gitmessenger", "telescope", "man" },
      -- Optional: Automatically load the last session on Neovim startup
      autoload = {
        enabled = true,
        -- You may want to disable this if you use other session managers
        -- command = 'RestoreSession', 
      },
      -- Optional: List of commands to be executed when a session is loaded.
      -- post_restore = { "cd " .. vim.fn.getcwd() },
    })
  end,

  keys = {
    { "<leader>qs", function() require("persistence").load() end, desc = "Restore last session" },
    { "<leader>ql", function() require("persistence").load() end, desc = "Load session" },
    { "<leader>qd", function() require("persistence").stop() end, desc = "Delete current session" },
  },
}
