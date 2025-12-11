-- SETUP: UI & Colors
vim.api.nvim_set_hl(0, "TerminalBackground", { bg = "#1e1e1e" })

-- STATE
local state = {
  terminal = {
    buf = -1,
    win = -1,
    position = "floating", -- 'floating', 'side_panel', or 'full'
    terminals = {},
    current_index = 1,
  },
}

-- Get Floating Config
local function get_floating_config()
  local width = math.floor(vim.o.columns * 0.8)
  local height = math.floor(vim.o.lines * 0.8)
  local col = math.floor((vim.o.columns - width) / 2)
  local row = math.floor((vim.o.lines - height) / 2)

  return {
    relative = "editor",
    width = width,
    height = height,
    col = col,
    row = row,
    style = "minimal",
    border = "rounded",
    title = " Terminal " .. state.terminal.current_index .. "/" .. #state.terminal.terminals .. " ",
    title_pos = "center",
  }
end

-- Unified Open Function
local function open_window(buf, layout)
  local win = -1

  if layout == "floating" then
    win = vim.api.nvim_open_win(buf, true, get_floating_config())
    vim.api.nvim_win_set_option(win, "winhighlight", "Normal:TerminalBackground,FloatBorder:FloatBorder")
  elseif layout == "side_panel" then
    vim.cmd("botright vsplit") -- Split to the far right
    vim.cmd("vertical resize 80")
    win = vim.api.nvim_get_current_win()
    vim.api.nvim_win_set_buf(win, buf)
  elseif layout == "full" then
    vim.cmd.tabnew()
    win = vim.api.nvim_get_current_win()
    vim.api.nvim_win_set_buf(win, buf)
  end

  -- Update State
  state.terminal.win = win
  state.terminal.buf = buf
  state.terminal.position = layout

  -- Ensure Terminal Mode
  if vim.bo[buf].buftype ~= "terminal" then
    vim.cmd.term()
  end
  vim.cmd("startinsert")
end

-- Unified Toggle Function
local function toggle_terminal(layout)
  -- Case A: Window is already open
  if vim.api.nvim_win_is_valid(state.terminal.win) then
    -- If we are in the requested layout, toggle it OFF (close)
    if state.terminal.position == layout then
      vim.api.nvim_win_close(state.terminal.win, true)
      state.terminal.win = -1
      return
    end
    -- If we are in a DIFFERENT layout, close old and switch to new
    vim.api.nvim_win_close(state.terminal.win, true)
  end

  -- Open the terminal (Create new if none exist)
  if #state.terminal.terminals == 0 then
    local buf = vim.api.nvim_create_buf(false, true)
    table.insert(state.terminal.terminals, buf)
    state.terminal.current_index = 1
    open_window(buf, layout)
  else
    -- Open existing buffer
    local buf = state.terminal.terminals[state.terminal.current_index]
    if vim.api.nvim_buf_is_valid(buf) then
      open_window(buf, layout)
    else
      -- Reset if buffer became invalid
      state.terminal.terminals = {}
      toggle_terminal(layout) 
    end
  end
end

-- Create New Instance
local function create_new_terminal(layout)
  -- Close current if open to avoid clutter
  if vim.api.nvim_win_is_valid(state.terminal.win) then
    vim.api.nvim_win_close(state.terminal.win, true)
  end

  local buf = vim.api.nvim_create_buf(false, true)
  table.insert(state.terminal.terminals, buf)
  state.terminal.current_index = #state.terminal.terminals
  
  open_window(buf, layout)
end

-- 7. HELPER: Cycle Next/Prev
local function cycle_terminal(direction)
  if #state.terminal.terminals <= 1 then return end

  state.terminal.current_index = state.terminal.current_index + direction
  if state.terminal.current_index > #state.terminal.terminals then state.terminal.current_index = 1 end
  if state.terminal.current_index < 1 then state.terminal.current_index = #state.terminal.terminals end

  local next_buf = state.terminal.terminals[state.terminal.current_index]

  if vim.api.nvim_win_is_valid(state.terminal.win) then
    vim.api.nvim_win_set_buf(state.terminal.win, next_buf)
    -- Update title if floating
    if state.terminal.position == "floating" then
      vim.api.nvim_win_set_config(state.terminal.win, get_floating_config())
    end
    vim.cmd("startinsert")
  end
end

-- Run Current File
local filetype_commands = {
  python = "python3 %s", javascript = "node %s", lua = "lua %s",
  rust = "cargo run", go = "go run .", c = "gcc %s -o output && ./output",
  cpp = "g++ %s -o output && ./output",
}

local function run_current_file()
  local ft = vim.bo.filetype
  local cmd_fmt = filetype_commands[ft]
  if not cmd_fmt then return vim.notify("No command for: " .. ft, vim.log.levels.WARN) end

  local cmd = cmd_fmt:gsub("%%s", vim.fn.expand("%:p"))

  -- Default to floating if closed
  if not vim.api.nvim_win_is_valid(state.terminal.win) then
    toggle_terminal("floating")
  end

  local buf = state.terminal.terminals[state.terminal.current_index]
  local chan = vim.b[buf].terminal_job_id
  if chan then
    vim.api.nvim_chan_send(chan, "\x03" .. cmd .. "\r\n")
    vim.api.nvim_win_set_cursor(state.terminal.win, { vim.api.nvim_buf_line_count(buf), 0 })
    vim.cmd("startinsert")
  end
end

-- AUTO-RESIZE (Floating only)
vim.api.nvim_create_autocmd("VimResized", {
  callback = function()
    if vim.api.nvim_win_is_valid(state.terminal.win) and state.terminal.position == "floating" then
      vim.api.nvim_win_set_config(state.terminal.win, get_floating_config())
    end
  end,
})

-- EXPORT STATUS (For Lualine)
_G.get_term_status = function()
  if #state.terminal.terminals == 0 then return "" end
  return " " .. state.terminal.current_index .. "/" .. #state.terminal.terminals
end

-- 11. KEYMAPS
vim.keymap.set("t", "<esc><esc>", [[<C-\><C-n>]], { desc = "Exit terminal mode" })

-- Unified Toggle Maps
vim.keymap.set({ "n", "t" }, "<space>tt", function() toggle_terminal("floating") end, { desc = "Toggle floating terminal" })
vim.keymap.set({ "n", "t" }, "<space>ts", function() toggle_terminal("side_panel") end, { desc = "Toggle side terminal" })
vim.keymap.set({ "n", "t" }, "<space>tf", function() toggle_terminal("full") end, { desc = "Toggle full terminal" })

-- Unified New Maps
vim.keymap.set("n", "<space>tn", function() create_new_terminal("floating") end, { desc = "New floating terminal" })
vim.keymap.set("n", "<space>tN", function() create_new_terminal("side_panel") end, { desc = "New side terminal" })
vim.keymap.set("n", "<space>tF", function() create_new_terminal("full") end, { desc = "New full terminal" })

vim.keymap.set({ "n", "t" }, "<space>]]", function() cycle_terminal(1) end, { desc = "Next terminal" })
vim.keymap.set({ "n", "t" }, "<space>[[", function() cycle_terminal(-1) end, { desc = "Prev terminal" })
vim.keymap.set("n", "<space>tr", run_current_file, { desc = "Run current file" })
