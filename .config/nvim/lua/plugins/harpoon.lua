return {
    {
      "ThePrimeagen/harpoon",
      branch = "harpoon2",
      dependencies = { "nvim-lua/plenary.nvim" },
      config = function()
        local harpoon = require("harpoon")
        local extensions = require("harpoon.extensions")
  
        -- setup
        harpoon:setup()
  
        harpoon:extend({
          UI_CREATE = function(cx)
            vim.keymap.set("n", "<C-v>", function()
              harpoon.ui:select_menu_item({ vsplit = true })
            end, { buffer = cx.bufnr })
  
            vim.keymap.set("n", "<C-x>", function()
              harpoon.ui:select_menu_item({ split = true })
            end, { buffer = cx.bufnr })
  
            vim.keymap.set("n", "<C-t>", function()
              harpoon.ui:select_menu_item({ tabedit = true })
            end, { buffer = cx.bufnr })
          end,
        })
  
        -- keymaps
        vim.keymap.set("n", "<leader>ha", function() harpoon:list():add() vim.notify("Harpooned! 🔔")
        end, { desc = "Add file to harpoon list" })

        vim.keymap.set("n", "<leader>hm", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "Open Harpoon Menu"})
        vim.keymap.set("n", "<leader>h1", function() harpoon:list():select(1) end)
        vim.keymap.set("n", "<leader>h2", function() harpoon:list():select(2) end)
        vim.keymap.set("n", "<leader>h3", function() harpoon:list():select(3) end)
        vim.keymap.set("n", "<leader>h4", function() harpoon:list():select(4) end)
  
        -- Toggle previous & next
        vim.keymap.set("n", "<C-h>", function() harpoon:list():prev() end)
        vim.keymap.set("n", "<C-l>", function() harpoon:list():next() end)
  
        -- Telescope integration
        local conf = require("telescope.config").values
        local function toggle_telescope(harpoon_files)
          local file_paths = {}
          for _, item in ipairs(harpoon_files.items) do
            table.insert(file_paths, item.value)
          end
  
          require("telescope.pickers").new({}, {
            prompt_title = "Harpoon",
            finder = require("telescope.finders").new_table({
              results = file_paths,
            }),
            previewer = conf.file_previewer({}),
            sorter = conf.generic_sorter({}),
          }):find()
        end
  
        vim.keymap.set("n", "<leader>hm", function()
          toggle_telescope(harpoon:list())
        end, { desc = "Open harpoon window" })
      end,
    }
  }
  
