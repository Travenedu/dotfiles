# Neovim Configuration

This is a personalized Neovim configuration based on the LazyVim distribution.

## Keymaps

The leader key is set to `space`.

### General

| Mode | Keybinding | Description |
| :--- | :--- | :--- |
| n | `<F2>` | Toggle Cheatsheet |
| n | `Q` | Repeat last macro |
| v | `<` | Inner indent while remaining in visual mode |
| v | `>` | Outer indent while remaining in visual mode |
| all | `<C-s>` | Save File |
| n | `<leader>nd` | Dismiss Noice messages |
| n | `<leader>mf` | Yank file with filename as heading in markdown |
| v | `<leader>ms` | Yank selection with filename as heading in markdown |
| n | `<leader>fml` | Cellular Automaton: Make it rain |

### Window Management

| Mode | Keybinding | Description |
| :--- | :--- | :--- |
| n | `<leader>wv` | Split window vertically |
| n | `<leader>wh` | Split window horizontally |
| n | `<leader>we` | Make splits equal size |
| n | `<leader>wr` | Rotate splits |
| n | `<leader>wx` | Close current split |
| n | `<leader>wo` | Close all other windows |

### Tab Management

| Mode | Keybinding | Description |
| :--- | :--- | :--- |
| n | `<leader><tab>l` | Go to Last Tab |
| n | `<leader><tab>o` | Close Other Tabs |
| n | `<leader><tab>f` | Go to First Tab |
| n | `<leader><tab><tab>` | New Tab |
| n | `<leader><tab>]` | Go to Next Tab |
| n | `<leader><tab>d` | Close Current Tab |
| n | `<leader><tab>[` | Go to Previous Tab |

### Yanking and Pasting

| Mode | Keybinding | Description |
| :--- | :--- | :--- |
| v | `<leader>y` | Yank selection to clipboard |
| n | `<leader>yy` | Yank current line to clipboard |
| n | `<leader>yl` | Yank to end of line to clipboard |
| n, v, x | `<leader>p` | Paste from clipboard |

### LSP (Language Server Protocol)

| Mode | Keybinding | Description |
| :--- | :--- | :--- |
| n | `K` | Show documentation (hover) |
| n | `gd` | Go to definition |
| n, v | `<leader>ca` | Show code actions |
| n | `<leader>gf` | Format file |

### Harpoon

| Mode | Keybinding | Description |
| :--- | :--- | :--- |
| n | `<leader>a` | Add file to harpoon list |
| n | `<C-e>` | Open Harpoon Menu |
| n | `<C-1>` | Go to harpoon mark 1 |
| n | `<C-2>` | Go to harpoon mark 2 |
| n | `<C-3>` | Go to harpoon mark 3 |
| n | `<C-4>` | Go to harpoon mark 4 |
| n | `<C-h>` | Go to previous harpoon mark |
| n | `<C-l>` | Go to next harpoon mark |

### Snipe

| Mode | Keybinding | Description |
| :--- | :--- | :--- |
| n | `gb` | Open Snipe buffer menu |

### Snacks

| Mode | Keybinding | Description |
| :--- | :--- | :--- |
| n | `<leader><space>` | Smart Find Files |
| n | `<leader>fe` | File Explorer |
| n | `<leader>fb` | Buffers |
| n | `<leader>fc` | Find Config File |
| n | `<leader>ff` | Find Files |
| n | `<leader>fp` | Projects |
| n | `<leader>fr` | Recent |
| n | `<leader>fR` | Rename File |
| n | `<leader>sb` | Grep Open Buffers |
| n | `<leader>sg` | Grep |
| n, x | `<leader>sw` | Visual selection or word |
| n | `<leader>s"` | Registers |
| n | `<leader>s/` | Search History |
| n | `<leader>sl` | Search Lines |
| n | `<leader>sc` | Command History |
| n | `<leader>sC` | Commands |
| n | `<leader>sd` | Diagnostics |
| n | `<leader>sh` | Help Pages |
| n | `<leader>sH` | Highlights |
| n | `<leader>si` | Icons |
| n | `<leader>sj` | Jumps |
| n | `<leader>sk` | Keymaps |
| n | `<leader>sm` | Marks |
| n | `<leader>sM` | Man Pages |
| n | `<leader>sp` | Search for Plugin Spec |
| n | `<leader>sq` | Quickfix List |
| n | `<leader>sR` | Resume |
| n | `<leader>su` | Undo History |
| n | `<leader>gb` | Git Branches |
| n | `<leader>gl` | Git Log |
| n | `<leader>gL` | Git Log Line |
| n | `<leader>gs` | Git Status |
| n | `<leader>gS` | Git Stash |
| n | `<leader>gd` | Git Diff (Hunks) |
| n | `<leader>gf` | Git Log File |
| n | `<leader>ld` | Goto Definition |
| n | `<leader>lD` | Goto Declaration |
| n | `<leader>lr` | References |
| n | `<leader>lI` | Goto Implementation |
| n | `<leader>ly` | Goto T[y]pe Definition |
| n | `<leader>ls` | LSP Symbols |
| n | `<leader>lS` | LSP Workspace Symbols |
| n | `<leader>bD` | Buffer Diagnostics |
| n | `<leader>bd` | Delete Buffer |
| n | `<leader>bs` | Toggle Scratch Buffer |
| n | `<leader>bS` | Select Scratch Buffer |
| n | `<leader>CC` | Colorschemes |
| n | `<leader>z` | Toggle Zen Mode |
| n | `<leader>n` | Notification History |
| n, v | `<leader>gB` | Git Browse |
| n | `<leader>gg` | Lazygit |
| n | `<leader>un` | Dismiss All Notifications |
| n | `<c-/>` | Toggle Terminal |
| n, t | `]]` | Next Reference |
| n, t | `[[` | Prev Reference |
| n | `<leader>us` | Toggle Spelling |
| n | `<leader>uw` | Toggle Wrap |
| n | `<leader>uL` | Toggle Relative Number |
| n | `<leader>ud` | Toggle Diagnostics |
| n | `<leader>ul` | Toggle Line Number |
| n | `<leader>uc` | Toggle Conceal Level |
| n | `<leader>uT` | Toggle Treesitter |
| n | `<leader>ub` | Toggle Dark Background |
| n | `<leader>uh` | Toggle Inlay Hints |
| n | `<leader>ug` | Toggle Indent |
| n | `<leader>uD` | Toggle Dim |

## Plugins

This configuration is managed by `lazy.nvim`. Plugins are organized by category below.

### Core

| Plugin | Description |
| :--- | :--- |
| `completions` | Provides code completion suggestions as you type. |
| `lsp-config` | Configures the Language Server Protocol for rich language features. |
| `none-ls` | Integrates formatters and linters for consistent code style. |
| `treesitter` | Enables advanced, accurate syntax highlighting and code parsing. |

### Editing

| Plugin | Description |
| :--- | :--- |
| `inline-diagnostic` | Shows code diagnostics (errors, warnings) directly in the buffer. |
| `snipe` | Improves upon the `f` and `F` motions for faster navigation. |

### Git

| Plugin | Description |
| :--- | :--- |
| `gitsigns` | Shows git status indicators in the sign column. |
| `lazygit` | Provides a powerful terminal UI for managing git. |

### UI

| Plugin | Description |
| :--- | :--- |
| `alpha` | Displays a customizable startup screen. |
| `colorschemes` | Manages and applies different color themes. |
| `huez` | Dynamically changes UI colors based on the current file's content. |
| `lualine` | A highly configurable and beautiful status line. |
| `noice` | Replaces the default UI for messages and commands. |
| `snacks` | Shows prettier, more modern notifications. |
| `tabs` | Provides enhanced tab management and display. |
| `which-key` | Displays a popup with possible keybindings after a prefix key. |

### Utility

| Plugin | Description |
| :--- | :--- |
| `harpoon` | Allows you to mark and quickly jump between files and commands. |
| `nvcheatsheet` | Displays a cheatsheet of available keybindings. |
| `telescope` | A powerful fuzzy finder for files, buffers, git, and more. |

### Misc

| Plugin | Description |
| :--- | :--- |
| `cellular-automaton` | A fun plugin that runs Conway's Game of Life. |
