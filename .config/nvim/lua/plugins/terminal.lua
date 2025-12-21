return {
	"akinsho/toggleterm.nvim",
	version = "*",
	config = function()
		local toggleterm = require("toggleterm")
		local terminal = require("toggleterm.terminal")

		toggleterm.setup({
			size = function(term)
				if term.direction == "horizontal" then
					return 15
				elseif term.direction == "vertical" then
					return vim.o.columns * 0.4
				end
			end,
			open_mapping = [[<c-\>]],
			hide_numbers = true,
			shade_terminals = true,
			shading_factor = 2,
			autochdir = true,
			start_in_insert = true,
			insert_mappings = true,
			terminal_mappings = true,
			persist_size = true,
			direction = "float",
			close_on_exit = true,
			float_opts = { border = "curved" },
			winbar = {
				enabled = true,
				name_formatter = function(term)
					return string.format("%d: %s", term.id, term.display_name)
				end,
			},
		})

		-- 1. TERMINAL KEYMAPS (Escaping and Window Navigation)
    function _G.set_terminal_keymaps()
        local function opts(description)
            return { buffer = 0, desc = description }
        end

        -- Navigation
        vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts("Move Left"))
        vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts("Move Down"))
        vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts("Move Up"))
        vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts("Move Right"))

        -- Escape Logic (Now you only need these if you want to stay in the term window)
        vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts("Normal Mode"))
        vim.keymap.set("t", "jk", [[<C-\><C-n>]], opts("Normal Mode"))

        -- Management
        vim.keymap.set("t", "<C-q>", [[<C-\><C-n><Cmd>close<CR>]], opts("Hide Terminal"))

        -- Force Kill: Stops process and deletes buffer
        vim.keymap.set("t", "<C-x>", function()
            vim.cmd("stopinsert")
            local current_buf = vim.api.nvim_get_current_buf()
            vim.cmd("bdelete! " .. current_buf)
        end, opts("Kill Terminal"))
    end
		vim.cmd("autocmd! TermOpen term://*toggleterm#* lua set_terminal_keymaps()")
    -- When entering a terminal buffer, automatically switch to insert mode
    vim.cmd("autocmd! BufEnter term://*toggleterm#* startinsert")

		-- 2. RUN CURRENT FILE LOGIC
		local function run_current_file()
			local ft = vim.bo.filetype
			local filename = '"' .. vim.fn.expand("%:p") .. '"'
			local commands = {
				python = "python3 " .. filename,
				javascript = "node " .. filename,
				lua = "lua " .. filename,
				sh = "bash " .. filename,
				bash = "bash " .. filename,
				go = "go run " .. filename,
				rust = "cargo run",
			}
			local cmd = commands[ft]
			if not cmd then return vim.notify("No command for " .. ft) end
			vim.cmd(string.format("TermExec cmd='%s'", cmd))
		end

		-- 3. NAVIGATION & MULTI-TERM LOGIC
		local function get_project_root()
			local cwd = vim.fn.getcwd()
			local git_dir = vim.fn.finddir(".git", cwd .. ";")
			return git_dir ~= "" and vim.fn.fnamemodify(git_dir, ":h") or cwd
		end

		local function create_new_terminal(dir)
			local project_root = get_project_root()
			vim.ui.input({ prompt = "Terminal Name: " }, function(name)
				if not name then return end
				if name == "" then name = "Shell" end

				local all_terms = terminal.get_all()
				local max_id = 0
				for _, t in ipairs(all_terms) do
					if t.id > max_id then max_id = t.id end
				end

				terminal.Terminal:new({
					id = max_id + 1,
					display_name = name,
					dir = project_root,
					direction = dir,
				}):toggle()
			end)
		end

		local function create_quick_terminal(dir)
			local project_root = get_project_root()
			local all_terms = terminal.get_all()
			local max_id = 0
			for _, t in ipairs(all_terms) do
				if t.id > max_id then max_id = t.id end
			end

			terminal.Terminal:new({
				id = max_id + 1,
				display_name = "Quick Term",
				dir = project_root,
				direction = dir,
			}):toggle()
		end

		local function smart_toggle(dir)
    local all_terms = terminal.get_all()
    
    -- 1. If no terminals exist, create the first one with a name
    if #all_terms == 0 then
        create_new_terminal(dir)
        return
    end

    -- 2. Find the "active" or last-focused terminal
    -- ToggleTerm usually tracks the 'current' one via ID or focus
    local current_buf = vim.api.nvim_get_current_buf()
    local target_term = nil

    -- Check if we are currently inside a terminal window
    for _, t in ipairs(all_terms) do
        if t.bufnr == current_buf then
            target_term = t
            break
        end
    end

    -- If we aren't inside a terminal, get the last one that was toggled
    if not target_term then
        target_term = all_terms[#all_terms]
    end

    -- 3. THE MAGIC: If the terminal is open but in the wrong layout, change it
    if target_term:is_open() and target_term.direction ~= dir then
        target_term:close() -- Close it in the old layout
        target_term.direction = dir -- Change its "shape"
        target_term:open() -- Re-open it in the new layout
    else
        -- Otherwise, just perform a normal toggle
        vim.cmd("ToggleTerm direction=" .. dir)
    end
  end

		local function cycle_terminal(step)
			local all_terms = terminal.get_all()
			if #all_terms <= 1 then return end
			local current_buf = vim.api.nvim_get_current_buf()
			local current_index = 0
			table.sort(all_terms, function(a, b) return a.id < b.id end)
			for i, t in ipairs(all_terms) do
				if t.bufnr == current_buf then current_index = i break end
			end
			local next_index = current_index + step
			if next_index > #all_terms then next_index = 1 end
			if next_index < 1 then next_index = #all_terms end
			local target_term = all_terms[next_index]
			if target_term then
				vim.cmd("ToggleTerm")
				vim.cmd(target_term.id .. "ToggleTerm")
			end
		end

		local function rename_current_terminal()
			local current_buf = vim.api.nvim_get_current_buf()
			for _, t in ipairs(terminal.get_all()) do
				if t.bufnr == current_buf then
					vim.ui.input({ prompt = "New Terminal Name: " }, function(input)
						if input and input ~= "" then t.display_name = input end
					end)
					break
				end
			end
		end

		-- 4. CUSTOM TUI WRAPPERS
		local function create_custom_term(command, name)
			return terminal.Terminal:new({
				cmd = command,
				display_name = name,
				hidden = true,
				direction = "float",
				on_open = function(term)
					vim.cmd("startinsert!")
					vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
				end,
			})
		end

    -- Custom TUI Wrappers
		local lazygit    = create_custom_term("lazygit", "Git")
		local btop       = create_custom_term("btop", "System")
		local python     = create_custom_term("python3", "Python")
		local node       = create_custom_term("node", "Node")
		local lazydocker = create_custom_term("lazydocker", "Docker")

		-- Global lualine status function
		_G.get_term_status = function()
			local all_terms = terminal.get_all()
			if #all_terms == 0 then return "" end

			local current_buf = vim.api.nvim_get_current_buf()
			
			-- 1. Check if we are currently looking at a terminal buffer
			for _, t in ipairs(all_terms) do
				if t.bufnr == current_buf then
					return string.format("  %d: %s", t.id, t.display_name or "Shell")
				end
			end

			-- 2. If we are in a code buffer, show the last active terminal
			local last_term = all_terms[#all_terms]
			if last_term then
				return string.format("  %d: %s", last_term.id, last_term.display_name or "Shell")
			end
			return ""
		end

		-- 5. APPLY KEYMAPS
		local function desc(txt)
			return { noremap = true, silent = true, desc = txt }
		end

		-- REPL & Runner
		vim.keymap.set("n", "<leader>sl", "<cmd>ToggleTermSendCurrentLine 1<cr>", desc("Send Line to Term 1"))
		vim.keymap.set("v", "<leader>ss", "<cmd>ToggleTermSendVisualSelection 1<cr>", desc("Send Selection to Term 1"))
		vim.keymap.set("n", "<space>tr", run_current_file, desc("Run Current File"))

		-- Toggles & Layouts
		vim.keymap.set({ "n", "t" }, "<space>tt", function() smart_toggle("float") end, desc("Toggle Float"))
		vim.keymap.set({ "n", "t" }, "<space>ts", function() smart_toggle("vertical") end, desc("Toggle Vertical"))
		vim.keymap.set({ "n", "t" }, "<space>tf", function() smart_toggle("tab") end, desc("Toggle Tab/Full"))

		-- New Instances (Named & Quick)
		vim.keymap.set("n", "<space>tn", function() create_new_terminal("float") end, desc("New Named Float"))
		vim.keymap.set("n", "<space>tN", function() create_new_terminal("horizontal") end, desc("New Named Horizontal"))
		vim.keymap.set("n", "<space>tq", function() create_quick_terminal("float") end, desc("Quick Float Term"))
		vim.keymap.set("n", "<space>tQ", function() create_quick_terminal("horizontal") end, desc("Quick Horizontal Term"))
		
		-- Management
		vim.keymap.set("n", "<leader>tl", "<cmd>TermSelect<cr>", desc("List Terminals"))
		vim.keymap.set("n", "<space>tR", rename_current_terminal, desc("Rename Current Term"))
		vim.keymap.set({ "n", "t" }, "<space>]]", function() cycle_terminal(1) end, desc("Next Terminal"))
		vim.keymap.set({ "n", "t" }, "<space>[[", function() cycle_terminal(-1) end, desc("Prev Terminal"))

		-- TUI Tools
		vim.keymap.set("n", "<leader>tg",  function() lazygit:toggle() end, desc("LazyGit"))
		vim.keymap.set("n", "<leader>tb", function() btop:toggle() end, desc("Btop"))
		vim.keymap.set("n", "<leader>tp", function() python:toggle() end, desc("Python REPL"))
		vim.keymap.set("n", "<leader>td", function() lazydocker:toggle() end, desc("LazyDocker"))
	end,
}
