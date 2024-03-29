-- add indentation guides even on blank lines

local M = {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  event = { "BufReadPost", "BufNewFile" },
  -- opts = {
  -- indentLine_enabled = 1,
  -- char = "▏",
  -- filetype_exclude = {
  --   "startify",
  --   "dashboard",
  --   "dotooagenda",
  --   "log",
  --   "fugitive",
  --   "gitcommit",
  --   "packer",
  --   "vimwiki",
  --   "markdown",
  --   "json",
  --   "txt",
  --   "vista",
  --   "help",
  --   "todoist",
  --   "NvimTree",
  --   "neo-tree",
  --   "peekaboo",
  --   "git",
  --   "TelescopePrompt",
  --   "undotree",
  --   "flutterToolsOutline",
  --   "", -- for all buffers without a file type
  -- },
  --buftype_exclude = { "terminal", "nofile" },
  -- show_trailing_blankline_indent = false,
  --show_first_indent_level = true,
  -- show_current_context = true,
  -- char_list = { "|", "¦", "┆", "┊" },
  -- space_char = " ",
  -- context_patterns = {
  --   "class",
  --   "function",
  --   "method",
  --   "block",
  --   "list_literal",
  --   "selector",
  --   "^if",
  --   "^table",
  --   "if_statement",
  --   "while",
  --   "for",
  -- },
  -- },
}

return M
