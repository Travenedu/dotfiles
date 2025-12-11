return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    -- NOTE: The global function _G.get_term_status() must be defined 
    -- in your floating terminal configuration file for this to work.

    require('lualine').setup({
      options = {
        theme = 'auto',
        -- Set a separator between sections for better visual grouping
        section_separators = { left = '', right = '' },
        component_separators = { left = '', right = '' },
      },
      sections = {
        -- Left side (Default: mode, filename)
        lualine_a = { 'mode' },
        lualine_b = { 'filename', 'branch' },

        -- Center section (Default: LSP status)
        lualine_c = { 'filetype', 'lsp_progress' },

        -- Right side 1: Custom components
        lualine_x = {
          -- Component to show terminal status
          {
            -- Calls the global function defined in your terminal setup
            function()
              return _G.get_term_status()
            end,
            -- Only show if the function exists and returns a non-empty string
            cond = function()
              return _G.get_term_status ~= nil and _G.get_term_status() ~= ""
            end,
            -- Optional: Highlight color for visibility
            color = { fg = '#ff9e64' },
          },
          'encoding',
          'fileformat',
        },

        -- Right side 2 (Default: line and column)
        lualine_y = { 'location' },
        lualine_z = { 'progress' }
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { 'filename' },
        lualine_x = { 'location' },
        lualine_y = {},
        lualine_z = {}
      },
    })
  end
}
