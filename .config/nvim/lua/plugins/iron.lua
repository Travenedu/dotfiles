return {
  "hkupty/iron.nvim",
  config = function()
    local iron = require("iron.core")
    local common = require("iron.fts.common")

    iron.setup({
      config = {
        scratch_repl = true,
        repl_definition = {
          sh = {
            command = { "zsh" },
          },
          python = {
            command = { "python3" },  -- or { "ipython", "--no-autoindent" }
            format = common.bracketed_paste_python,
            block_dividers = { "# %%", "# %%%" },
            env = {PYTHON_BASIC_REPL = "1"}
          },
        },
        repl_open_cmd = require("iron.view").right(40),
      },
      -- Iron doesn't set keymaps by default
      keymaps = {
        send_motion = "<space>sc",
        visual_send = "<space>sc",
        send_file = "<space>sf",
        send_line = "<space>sl",
        send_mark = "<space>sm",
        mark_motion = "<space>mc",
        mark_visual = "<space>mc",
        remove_mark = "<space>md",
        cr = "<space>s<cr>",
        interrupt = "<space>s<space>",
        exit = "<space>sq",
        clear = "<space>cl",
      },
      highlight = {
        italic = true,
      },
      ignore_blank_lines = true,
    })

    vim.keymap.set("n", "<space>rs", "<cmd>IronRepl<cr>")
    vim.keymap.set("n", "<space>rr", "<cmd>IronRestart<cr>")
    vim.keymap.set("n", "<space>rf", "<cmd>IronFocus<cr>")
    vim.keymap.set("n", "<space>rh", "<cmd>IronHide<cr>")
  end,
}
