local M = {}

-- local doc_win = nil

function M.copy_diagnostic()
	local line_diagnostics = vim.diagnostic.get(0, { lnum = vim.fn.line(".") - 1 })
	if vim.tbl_isempty(line_diagnostics) then
		print("No diagnostics found on this line.")
		return
	end
	table.sort(line_diagnostics, function(a, b)
		return a.severity < b.severity
	end)
	local message = line_diagnostics[1].message
	vim.fn.setreg("+", message)
	print("Copied diagnostic: " .. message)
end

-- Add hover for documentation
-- function M.toggle_hover_vertical()
-- 	if doc_win and vim.api.nvim_win_is_valid(doc_win) then
-- 		vim.api.nvim_win_close(doc_win, true)
-- 		doc_win = nil
-- 		return
-- 	end
--
-- 	local params = vim.lsp.util.make_position_params()
-- 	vim.lsp.buf_request(0, "textDocument/hover", params, function(err, result)
-- 		if err or not (result and result.contents) then
-- 			return
-- 		end
--
-- 		vim.cmd("vertical stopen")
-- 		vim.cmd("vertical resize 50")
--
-- 		doc_win = vim.api.nvim_get_current_win()
-- 		local buf = vim.api.nvim_create_buf(false, true)
-- 		vim.api.nvim_win_set_buf(doc_win, buf)
--
-- 		local contents = vim.lsp.util.convert_input_to_markdown_lines(result.contents)
-- 		vim.api.nvim_buf_set_lines(buf, 0, -1, false, contents)
--
-- 		vim.api.nvim_set_option_value("filetype", "markdown", { buf = buf })
-- 		vim.api.nvim_set_option_value("buftype", "nofile", { buf = buf })
-- 		vim.cmd("wincmd p")
-- 	end)
-- end

return M
