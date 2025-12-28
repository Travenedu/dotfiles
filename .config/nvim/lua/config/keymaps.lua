local function map(mode, keys, action, desc, opts)
	local defaults = { desc = desc or "", noremap = true, silent = true }
	local merged = vim.tbl_extend("force", defaults, opts or {})
	vim.keymap.set(mode, keys, action, merged)
end

vim.g.mapleader = " "

-- Save file
map({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", "Save File")

-- Line Navigation (Simplified)
map({ "n", "v" }, "<leader>hh", "^", "Go to start of line")
map({ "n", "v" }, "<leader>ll", "$", "Go to end of line")

-- Navigation: Keep cursor centered when jumping
map("n", "<C-d>", "<C-d>zz", "Scroll Down (Centered)")
map("n", "<C-u>", "<C-u>zz", "Scroll Up (Centered)")
map("n", "n", "nzzzv", "Next Search Result (Centered)")
map("n", "N", "Nzzzv", "Prev Search Result (Centered)")

-- Split Navigation (Alt + hjkl to move between windows)
map("n", "<A-h>", "<C-w>h", "Navigate Left")
map("n", "<A-j>", "<C-w>j", "Navigate Down")
map("n", "<A-k>", "<C-w>k", "Navigate Up")
map("n", "<A-l>", "<C-w>l", "Navigate Right")

-- Better manual indenting (gv keeps the selection active)
map("v", "<", "<gv", "Indent Left")
map("v", ">", ">gv", "Indent Right")

-- Repeat last macro
map("n", "Q", "@@", "Repeat last macro")

-- Window Management (Fixed Duplicates)
map("n", "<leader>wv", "<C-w>v", "Split Vertical")
map("n", "<leader>ws", "<C-w>s", "Split Horizontal") -- Changed from wh to ws
map("n", "<leader>we", "<C-w>=", "Equal Size Splits")
map("n", "<leader>wx", "<cmd>close<CR>", "Close Split")

-- Move Split Positions
map("n", "<leader>wH", "<C-w>H", "Move Split Left")
map("n", "<leader>wJ", "<C-w>J", "Move Split Down")
map("n", "<leader>wK", "<C-w>K", "Move Split Up")
map("n", "<leader>wL", "<C-w>L", "Move Split Right")

-- Tabs (Cleaned up prefix)
map("n", "<leader>tn", "<cmd>tabnew<cr>", "New Tab")
map("n", "<leader>t]", "<cmd>tabnext<cr>", "Next Tab")
map("n", "<leader>t[", "<cmd>tabprevious<cr>", "Prev Tab")
map("n", "<leader>tx", "<cmd>tabclose<cr>", "Close Tab")

-- Yanking and Pasting
map("v", "<leader>y", [["+y]], "Yank to clipboard")
map("n", "<leader>Y", [["+yy]], "Yank line to clipboard")
map({ "n", "v" }, "<leader>p", '"+p', "Paste from clipboard")

-- Your custom Markdown Yanking logic (Kept exactly as is)
local wrap_with_markdown = function(content)
	local path = vim.fn.expand("%:.")
	local filetype = vim.bo.filetype == "typescriptreact" and "jsx" or vim.bo.filetype
	local result = table.concat({ "- ", path, "\n```", filetype, "\n", content, "\n```" })
	vim.fn.setreg("+", result)
end

map("n", "<leader>yf", function()
	local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
	wrap_with_markdown(table.concat(lines, "\n"))
	vim.notify("File copied with MD formatting")
end, "Yank file as MD")

map("v", "<leader>ys", function()
	local v_start = vim.fn.getpos("'<")
	local v_end = vim.fn.getpos("'>")
	local lines = vim.api.nvim_buf_get_lines(0, v_start[2] - 1, v_end[2], false)
	wrap_with_markdown(table.concat(lines, "\n"))
	vim.notify("Selection copied with MD formatting")
end, "Yank selection as MD")

-- Dismiss Messages
map("n", "<leader>nd", "<cmd>NoiceDismiss<CR>", "Dismiss Messages")
