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
	pattern = { "help", "man", "qf", "lspinfo", "checkhealth", "notify", "lazy", "gitsigns.blame", "neotest-output" },
	callback = function(event)
		vim.bo[event.buf].buflisted = false
		vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
	end,
})



-- 6. Trim trailing whitespace on save
vim.api.nvim_create_autocmd("BufWritePre", {
	group = augroup("trim_whitespace"),
	pattern = "*",
	callback = function()
		local save = vim.fn.winsaveview()
		vim.cmd([[keeppatterns %s/\s\+$//e]])
		vim.fn.winrestview(save)
	end,
})

-- 7. Check if we need to reload the file when it changed on disk
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
	group = augroup("checktime"),
	callback = function()
		if vim.o.buftype ~= "nofile" then
			vim.cmd("checktime")
		end
	end,
})

-- 8. Auto-create missing directories on save
vim.api.nvim_create_autocmd("BufWritePre", {
	group = augroup("auto_create_dir"),
	callback = function(event)
		if event.match:match("^%w%w+:[\\/][\\/]") then
			return
		end
		local file = vim.uv.fs_realpath(event.match) or event.match
		vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
	end,
})

-- 9. Enable wrap and spell for text-based files
vim.api.nvim_create_autocmd("FileType", {
	group = augroup("wrap_spell"),
	pattern = { "gitcommit", "markdown", "text", "plaintex" },
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.spell = true
	end,
})

-- 10. Show cursor line only in active window
local cursor_grp = augroup("CursorLine")
vim.api.nvim_create_autocmd({ "InsertLeave", "WinEnter" }, {
	group = cursor_grp,
	pattern = "*",
	callback = function()
		vim.opt_local.cursorline = true
	end,
})
vim.api.nvim_create_autocmd({ "InsertEnter", "WinLeave" }, {
	group = cursor_grp,
	pattern = "*",
	callback = function()
		vim.opt_local.cursorline = false
	end,
})
