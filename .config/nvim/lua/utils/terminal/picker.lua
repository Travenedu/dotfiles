local M = {}

function M.terminal_buffers_picker()
    local pickers = require('telescope.pickers')
    local finders = require('telescope.finders')
    local conf = require('telescope.config').values
    local actions = require('telescope.actions')
    local action_state = require('telescope.actions.state')
    local previewers = require('telescope.previewers')
    local entry_display = require('telescope.pickers.entry_display')

    -- 1. Custom Display: Clean up "term://..." names
    local displayer = entry_display.create({
        separator = " ",
        items = {
            { width = 4 },   -- Column 1: Buffer ID
            { width = nil }, -- Column 2: Name
            { width = nil }, -- Column 3: PID/Info
        }
    })

    local make_display = function(entry)
        return displayer({
            { tostring(entry.value), "Number" },
            { entry.name, "String" },
            { entry.extra_info, "Comment" },
        })
    end

    -- 2. Buffer Collector: Scans ALL buffers (even unlisted ones)
    local terminal_bufs = {}
    for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
        if vim.api.nvim_buf_is_valid(bufnr) and vim.bo[bufnr].buftype == 'terminal' then
            table.insert(terminal_bufs, bufnr)
        end
    end

    if #terminal_bufs == 0 then
        vim.notify("No terminal buffers found.", vim.log.levels.WARN)
        return
    end

    -- 3. Entry Maker: Parses weird terminal names into readable text
    local entry_maker = function(bufnr)
        local raw_name = vim.api.nvim_buf_get_name(bufnr)
        -- Format: term://path//PID:Command
        -- Example: term://~/.config/nvim//28912:/bin/zsh

        local name = "Terminal"
        local extra = ""

        if raw_name:match("^term://") then
            -- Get the command (last part after :)
            local parts = vim.split(raw_name, ":")
            name = parts[#parts]
 
            -- Extract PID for extra info
            local pid = raw_name:match("//(%d+):")
            if pid then extra = "(PID: " .. pid .. ")" end
        else
            name = vim.fn.fnamemodify(raw_name, ":t")
        end

        return {
            value = bufnr,
            ordinal = raw_name, -- Keep raw name for fuzzy searching
            display = make_display,
            name = name,
            extra_info = extra,
        }
    end

    -- 4. Custom Previewer: Reads buffer content directly
    -- Standard file_previewer fails on terminals because they aren't files on disk.
    local term_previewer = previewers.new_buffer_previewer({
        define_preview = function(self, entry, status)
            -- Get the last 15 lines of the terminal buffer
            local lines = vim.api.nvim_buf_get_lines(entry.value, -15, -1, false)
            vim.api.nvim_buf_set_lines(self.state.bufnr, 0, -1, false, lines)
        end
    })

    -- 5. The Picker
    pickers.new({}, {
        prompt_title = "Terminal Buffers",
        finder = finders.new_table({
            results = terminal_bufs,
            entry_maker = entry_maker,
        }),
        sorter = conf.generic_sorter({}),
        previewer = term_previewer, -- Use our custom previewer
        initial_mode = "normal",
 
        attach_mappings = function(prompt_bufnr, map)
            -- Replace default action to simply switch to the buffer
            actions.select_default:replace(function()
                actions.close(prompt_bufnr)
                local selection = action_state.get_selected_entry()
                if selection then
                    vim.api.nvim_set_current_buf(selection.value)
                end
            end)
            return true
        end,
    }):find()
end

return M
