local function augroup(name)
	return vim.api.nvim_create_augroup("user_" .. name, { clear = true })
end

-- 1. Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
	group = augroup("highlight_yank"),
	callback = function()
		vim.highlight.on_yank({ timeout = 200 })
	end,
})

-- 2. Resize splits if window is resized
vim.api.nvim_create_autocmd("VimResized", {
	group = augroup("resize_splits"),
	callback = function()
		vim.cmd("wincmd =")
	end,
})

-- 3. Go to last loc when opening a buffer
vim.api.nvim_create_autocmd("BufReadPost", {
	group = augroup("last_loc"),
	callback = function(event)
		local exclude = { "gitcommit" }
		local buf = event.buf
		if vim.tbl_contains(exclude, vim.bo[buf].filetype) then
			return
		end
		local mark = vim.api.nvim_buf_get_mark(buf, '"')
		local lcount = vim.api.nvim_buf_line_count(buf)
		if mark[1] > 0 and mark[1] <= lcount then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
	end,
})

-- 4. Close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
	group = augroup("close_with_q"),
	pattern = { "help", "man", "qf", "lspinfo", "checkhealth", "notify" },
	callback = function(event)
		vim.bo[event.buf].buflisted = false
		vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
	end,
})

-- 5. Auto-detect Bash for extensionless files
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	group = augroup("bash_detect"),
	pattern = "*",
	callback = function()
		if vim.bo.filetype == "" or vim.bo.filetype == "text" then
			local line = vim.api.nvim_buf_get_lines(0, 0, 1, false)[1] or ""
			if line:match("^#!.*bin/bash") or line:match("^#!.*env%s+bash") then
				vim.bo.filetype = "sh"
			end
		end
	end,
})

-- 6. Trim trailing whitespace on save
vim.api.nvim_create_autocmd("BufWritePre", {
	group = augroup("trim_whitespace"),
	pattern = "*",
	callback = function()
		local save = vim.fn.winsaveview()
		vim.cmd([[%s/\s\+$//e]])
		vim.fn.winrestview(save)
	end,
})

-- 7. Check if we need to reload the file when it changed on disk
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
	group = augroup("checktime"),
	command = "checktime",
})
