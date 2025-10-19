local function map(mode, keys, action, desc, opts)
  local defaults = {
    desc = desc or "",
    noremap = true,
  }

  local merged = vim.tbl_extend("force", defaults, opts or {})
  vim.keymap.set(mode, keys, action, merged)
end
-- local map = vim.keymap.set

vim.g.mapleader = " "

-- save file
map({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", "Save File")

-- Move to start of line
vim.keymap.set('n', '<leader>hh', '^', { noremap = true, silent = true, desc = 'Go to start of line' })

-- Move to end of line
vim.keymap.set('n', '<leader>ll', '$', { noremap = true, silent = true, desc = 'Go to end of line' })

-- repeat last macro
map("n", "Q", "@@", "Repeat last macro")

-- better manual indenting
map("v", "<", "<gv<C-o>'<", "Inner indent while remaining in visual mode")
map("v", ">", ">gv<C-o>'<", "Outer indent while remaining in visual mode")

-- window management
map("n", "<leader>wv", "<C-w>v", "Split window vertically")
map("n", "<leader>wh", "<C-w>s", "Split window horizontally")
map("n", "<leader>we", "<C-w>=", "Make splits equal size")
map("n", "<leader>wr", "<C-w>r", "Rotate splits")
map("n", "<leader>wh", "<C-w>H", "Send split to the right")
map("n", "<leader>wj", "<C-w>J", "Send split to the botton")
map("n", "<leader>wk", "<C-w>K", "Send split to the top")
map("n", "<leader>wl", "<C-w>L", "Send split to the left")
map("n", "<leader>wx", "<cmd>close<CR>", "Close current split")
map("n", "<leader>wo", "<cmd>on<CR>", "Close all other windows")

-- tabs
map("n", "<leader><tab>l", "<cmd>tablast<cr>", "Last Tab")
map("n", "<leader><tab>o", "<cmd>tabonly<cr>", "Close Other Tabs")
map("n", "<leader><tab>f", "<cmd>tabfirst<cr>", "First Tab")
map("n", "<leader><tab><tab>", "<cmd>tabnew<cr>", "New Tab")
map("n", "<leader><tab>]", "<cmd>tabnext<cr>", "Next Tab")
map("n", "<leader><tab>d", "<cmd>tabclose<cr>", "Close Tab")
map("n", "<leader><tab>[", "<cmd>tabprevious<cr>", "Previous Tab")

-- yanking and pasting
map("v", "<leader>y", [["+y]], "Yank to clipboard")
map("n", "<leader>yy", [["+yy]], "Yank line to clipboard")
map("n", "<leader>yl", [["+yg_]], "Yank to end of line to clipboard")
map({ "n", "v", "x" }, "<leader>p", '"+p', "Paste from clipboard")

map("n", "<leader>nd", "<cmd>NoiceDismiss<CR>", "Dismiss Messages")

local wrap_with_markdown = function(content)
  local path = vim.fn.expand("%:.")
  local filetype = vim.bo.filetype == "typescriptreact" and "jsx" or vim.bo.filetype
  local result = table.concat({ "- ", path, "\n```", filetype, "\n", content, "\n```" })
  vim.fn.setreg("+", result)
end

map("n", "<leader>yf", function()
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  local content = table.concat(lines, "\n")
  wrap_with_markdown(content)
  vim.notify("Entire file copied with MD formatting")
end, "Yank file with filename as heading and wrap in md fence")

map("v", "<leader>ys", function()
  local v_start = vim.fn.getpos("'<")
  local v_end = vim.fn.getpos("'>")
  local lines = vim.api.nvim_buf_get_lines(0, v_start[2] - 1, v_end[2], false)
  local content = table.concat(lines, "\n")

  wrap_with_markdown(content)
  vim.notify("Selection copied with MD formatting")
end, "Yank selection with filename as heading and wrap in markdown")

