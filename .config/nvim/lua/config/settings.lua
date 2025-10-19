vim.loader.enable()

local opt = vim.opt

-- Search
opt.ignorecase = true -- Ignore case
opt.smartcase = true -- Don't ignore case with capitals
opt.hlsearch = true -- Don't highlight search results
opt.incsearch = true -- Incremental search
opt.grepprg = "rg --vimgrep"
opt.grepformat = "%f:%l:%c:%m"

-- Indentation
opt.expandtab = true -- Use spaces instead of tabs
opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
opt.autoindent = true
opt.smartindent = true -- Insert indents automatically
opt.shiftround = true -- Round indent

-- Appearance
opt.termguicolors = true -- True color support
opt.number = true -- Print line number
opt.cursorline = true -- Enable highlighting of the current line
opt.signcolumn = "yes" -- Always show the signcolumn, otherwise it would shift the text each time
opt.laststatus = 3 -- global statusline
opt.ruler = true -- Enable the ruler
opt.conceallevel = 2 -- Hide * markup for bold and italic, but not markers with substitutions
opt.pumblend = 10 -- Popup blend
opt.winminwidth = 5 -- Minimum window width
opt.fillchars = {
  foldopen = "",
  foldclose = "",
  fold = " ",
  foldsep = " ",
  diff = "╱",
  eob = " ",
}

-- Behavior
opt.autowrite = true -- Enable auto write
opt.confirm = true -- Confirm to save changes before exiting modified buffer
opt.undofile = true -- Save undo history
opt.wrap = false
opt.breakindent = true
opt.splitright = true
opt.splitbelow = true
opt.splitkeep = "screen"
opt.scrolloff = 4 -- Lines of context
opt.sidescrolloff = 8 -- Columns of context
opt.list = true -- Show some invisible characters (tabs...
opt.virtualedit = "block" -- Allow cursor to move where there is no text in visual block mode
opt.jumpoptions = "view"
opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" }

-- Folds
opt.foldenable = true
opt.foldmethod = "manual"
opt.foldlevel = 99

-- Performance
opt.updatetime = 300 -- Faster update time for plugins
opt.shortmess:append({ W = true, I = true, c = true, C = true })

-- Completion
opt.completeopt = "menu,menuone,noselect"
opt.pumheight = 10 -- Maximum number of entries in a popup
opt.inccommand = "nosplit" -- preview incremental substitute


-- Language specific
opt.spelllang = { "en" }
vim.g.markdown_recommended_style = 0 -- Fix markdown indentation settings
