-- Set leader
vim.g.mapleader = " "

-- Source your existing basic options & keymaps if they are separated:
-- require("config.options")
-- require("config.keymaps")

-- VS Code specific helper
local vscode = require("vscode")

-- Map Neovim keys to VS Code commands
vim.keymap.set("n", "<leader>ff", function()
    vscode.action("workbench.action.quickOpen")
end)
-- Find open buffers
vim.keymap.set("n", "<leader>fb", function()
    vscode.action("workbench.action.showAllEditors")
end)
-- Live grep / search text across project
vim.keymap.set("n", "<leader>fg", function()
    vscode.action("workbench.action.findInFiles")
end)
vim.keymap.set("n", "<leader>ca", function()
    vscode.action("editor.action.quickFix")
end)
vim.keymap.set("n", "<leader>rn", function()
    vscode.action("editor.action.rename")
end)
vim.keymap.set("n", "gr", function()
    vscode.action("editor.action.goToReferences")
end)


-- Toggle terminal panel (<leader>tt or <c-\>)
vim.keymap.set("n", "<leader>tt", function()
    vscode.action("workbench.action.createTerminalEditor")
end)

-- Open a new terminal instance (<leader>tn)
vim.keymap.set("n", "<leader>tn", function()
    vscode.action("workbench.action.terminal.new")
end)

-- Split terminal horizontally/side-by-side (<leader>ts)
vim.keymap.set("n", "<leader>ts", function()
    vscode.action("workbench.action.terminal.split")
end)

-- Kill / close the current terminal (<leader>tx)
vim.keymap.set("n", "<leader>tx", function()
    vscode.action("workbench.action.terminal.kill")
end)
-- Focus the terminal (<leader>tf)
vim.keymap.set("n", "<leader>tf", function()
    vscode.action("workbench.action.terminal.focus")
end)
-- Run current selected line(s) in terminal (<leader>tr in normal and visual mode)
vim.keymap.set({ "n", "v" }, "<leader>tr", function()
    vscode.action("workbench.action.terminal.runSelectedText")
end)

-- Run active file in terminal (e.g. python script.py / node file.js)
vim.keymap.set("n", "<leader>rf", function()
    vscode.action("workbench.action.terminal.runActiveFile")
end)
-- Next terminal (<leader>t])
vim.keymap.set("n", "<leader>t]", function()
    vscode.action("workbench.action.terminal.focusNext")
end)

-- Previous terminal (<leader>t[)
vim.keymap.set("n", "<leader>t[", function()
    vscode.action("workbench.action.terminal.focusPrevious")
end)
vim.keymap.set("n", "<leader>tm", function()
    vscode.action("workbench.action.terminal.moveToEditor")
end)
vim.keymap.set("n", "<leader>tp", function()
    vscode.action("workbench.action.terminal.moveToTerminalPanel")
end)
vim.keymap.set("n", "<leader>bb", function()
    vscode.action("workbench.action.navigateBack")
end)
