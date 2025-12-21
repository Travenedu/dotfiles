-- First, load the module you created in lua/utils/pickers.lua
-- local picker_utils = require('utils.terminal.picker')

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
vim.keymap.set({'n','v'}, '<leader>hh', '^', { noremap = true, silent = true, desc = 'Go to start of line' })

-- Move to end of line
vim.keymap.set({'n','v'}, '<leader>ll', '$', { noremap = true, silent = true, desc = 'Go to end of line' })

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

-- Messages
map("n", "<leader>nd", "<cmd>NoiceDismiss<CR>", "Dismiss Messages")

-- yanking and pasting
map("v", "<leader>yy", [["+y]], "Yank to clipboard")
map("n", "<leader>yl", [["+yy]], "Yank line to clipboard")
map("n", "<leader>ye", [["+yg_]], "Yank to end of line to clipboard")
map({ "n", "v", "x" }, "<leader>p", '"+p', "Paste from clipboard")

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

-- Come back to this later
-- -- Function to create a fold OR toggle an existing fold
-- local function toggle_or_create_fold()
--     -- 1. Check if we are in Visual Mode
--     local mode = vim.fn.mode()
--     if mode ~= 'v' and mode ~= 'V' and mode ~= '' then
--         vim.notify("Must be in Visual mode to create or toggle a fold.", vim.log.levels.WARN)
--         return
--     end
--
--     -- 2. Check if a fold *starts* at the selection's start line
--     -- This is the best way to determine if we should toggle (za) or create (zf)
--     local start_line = vim.fn.line('v') -- Get start line of selection
--
--     -- Check if a fold is already defined at this line.
--     -- vim.fn.foldclosed() returns -1 if the line is not in a closed fold.
--     -- This isn't perfect, but is the closest native check.
--     local is_fold = vim.fn.foldlevel(start_line) > 0
--
--     if is_fold then
--         -- If a fold exists at or near the selection, just toggle it.
--         -- We must exit visual mode first to perform the toggle command effectively.
--         vim.cmd('normal! ' .. start_line .. 'G') -- Go to the start line
--         vim.cmd('normal! za')                     -- Toggle the fold (open/close)
--     else
--         -- If no fold is readily identified, create the new fold.
--         -- 'zf' creates the fold from the visual selection
--         vim.cmd('normal! gvzf') -- Create fold over selected area
--         vim.cmd('normal! zc')   -- Collapse (close) the newly created fold
--     end
-- end
--
-- -- 3. KEYMAP: Select and Fold (Example using <leader>zf)
-- vim.keymap.set('v', '<leader>zf', toggle_or_create_fold, {
--     noremap = true,
--     silent = true,
--     desc = "Toggle fold or create/collapse new fold"
-- })

