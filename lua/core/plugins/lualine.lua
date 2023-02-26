-- fancier status line
local M = {
  "nvim-lualine/lualine.nvim",
  config = function()
    require('lualine').setup {
      options = {
        icons_enabled = true,
        globalstatus = false, -- one statusline for all windows...weird
        always_divide_middle = true,
        theme = 'auto', -- attempt to load them for colorscheme, or fake one up
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        sections = {
          lualine_a = { 'mode' },
          lualine_b = { 'branch', 'diff', 'diagnostics' },
          lualine_c = { 'filename' },
          lualine_x = { 'encoding', 'fileformat', 'filetype' },
          lualine_y = { 'progress' },
          lualine_z = { 'location' },
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { 'filename' },
          lualine_x = { 'location' },
          lualine_y = {},
          lualine_z = {},
        },
      },
    }
  end,
}

return M
