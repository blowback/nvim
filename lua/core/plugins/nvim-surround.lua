-- show marks in sign column
local M = {
  "kylechui/nvim-surround",
  config = function()
    require('nvim-surround').setup {
      -- this gets MERGED with the default config (which is gigantic)
      keymaps = {
        insert = "<C-g>s",
        insert_line = "<C-g>S",
        normal = "<leader>s", -- [S]urround [W]ord
        normal_cur = "<leader>ss", -- current line
        normal_line = "<leader>S", -- new line
        visual = "S",
        visual_line = "gS",
        delete = "<leader>sd",
        change = "<leader>sc",
      },
    }
  end,
}

return M
