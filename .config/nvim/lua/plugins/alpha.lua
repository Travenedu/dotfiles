return {
  {
    "goolord/alpha-nvim",
    event = "VimEnter",
    enabled = true,
    config = function()
      local dashboard_theme = require "alpha.themes.dashboard"

      -- Header Section
      local logo = [[
 ██████   █████              ███
░░██████ ░░███              ░░░
 ░███░███ ░███  █████ █████ ████  █████████████
 ░███░░███░███ ░░███ ░░███ ░░███ ░░███░░███░░███
 ░███ ░░██████  ░███  ░███  ░███  ░███ ░███ ░███
 ░███  ░░█████  ░░███ ███   ░███  ░███ ░███ ░███
 █████  ░░█████  ░░█████    █████ █████░███ █████
░░░░░    ░░░░░    ░░░░░    ░░░░░ ░░░░░ ░░░ ░░░░░

                            Code by Traven Reese
  ]]

      dashboard_theme.section.header.val = vim.split(logo, "\n")

      -- Buttons Section
      dashboard_theme.section.buttons.val = {
        dashboard_theme.button("<leader> ff", " Find file", function() Snacks.picker.files() end),
        dashboard_theme.button("<leader> fg", " Find text", function() Snacks.picker.grep() end),
        dashboard_theme.button("<leader> fp", " Find Project", function() Snacks.picker.projects() end),
        dashboard_theme.button("<leader> fo", " Recent files", function() Snacks.picker.recent() end),
        dashboard_theme.button(
          "<leader> ql",
          " Load Last Session",
          "<cmd>lua require('persistence').load({ last = true }) <CR>"
        ),
        dashboard_theme.button("n", " New file", "<cmd>ene <BAR> startinsert <CR>"),
        dashboard_theme.button("<leader> qq", " Close", "<cmd>q <CR>"),
        dashboard_theme.button(
          "<leader> cn",
          " Config",
          "<cmd>edit $MYVIMRC <CR> <cmd>cd " .. vim.fn.stdpath "config" .. " <CR>"
        ),
        dashboard_theme.button("<leader> CL", "𝓛Lazy", "<cmd>:Lazy<CR>"),
        dashboard_theme.button("<leader> CM", "𝓜 Mason", "<cmd>:Mason<CR>"),

      }
      dashboard_theme.section.buttons.opts.hl = "AlphaButtons"

      -- Layout
      dashboard_theme.opts.layout = {
        { type = "padding", val = 4 },
        dashboard_theme.section.header,
        { type = "padding", val = 2 },
        dashboard_theme.section.buttons,
        { type = "padding", val = 1 },
        dashboard_theme.section.footer,
      }

      -- Lazy Loading
      if vim.o.filetype == "lazy" then
        vim.cmd.close()
        vim.api.nvim_create_autocmd("User", {
          once = true,
          pattern = "AlphaReady",
          callback = function()
            require("lazy").show()
          end,
        })
      end

      -- Set the dashbaord
      require("alpha").setup(dashboard_theme.opts)

      -- Draw Footer After Startup
      vim.api.nvim_create_autocmd("User", {
        once = true,
        pattern = "LazyVimStarted",
        callback = function()
          local stats = require("lazy").stats()
          local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)

          -- Footer
          dashboard_theme.section.footer.val = "⚡ Neovim loaded "
            .. stats.loaded
            .. "/"
            .. stats.count
            .. " plugins in "
            .. ms
            .. "ms"
          pcall(vim.cmd.AlphaRedraw)
          dashboard_theme.section.footer.opts.hl = "AlphaFooter"
        end,
      })
    end,
  },
}
