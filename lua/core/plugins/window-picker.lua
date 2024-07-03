local M = {
  "s1n7ax/nvim-window-picker",
  version = "2.*",
  event = "VeryLazy",

  opts = {
    -- hint = "statusline-winbar",
    hint = "floating-big-letter",
    filter_rules = {
      -- if there's only one window, select it automatically
      autoselect_one = true,

      -- include current window in window selection
      include_current_win = false,

      -- filter using buffer options
      bo = {
        -- if the file type is one of following, the window will be ignored
        filetype = {
          "neo-tree",
          "neo-tree-popup",
          "notify",
          "packer",
          "qf",
          "diff",
          "fugitive",
          "fugitiveblame",
        },

        -- if the buffer type is one of following, the window will be ignored
        buftype = { "nofile", "help", "terminal" },
      },
    },
  },
}

return M
