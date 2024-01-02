-- show marks in sign column

local function add_mark(cache, glyph, initial)
  local name = "Marks_" .. initial
  cache[name] = true -- stop the signs plugin creating its own sign
  vim.fn.sign_define(name, { text = glyph, texthl = "MarkSignHL", numhl = "MarkSignNumHL" })
end

local function add_marks(utf8, cache, marks, initial)
  local b = string.byte(initial)
  local i = 1
  for _, c in utf8.codes(marks) do
    --local c = utf8.char(c)
    local n = string.char(b + i - 1)
    add_mark(cache, c, n)
    i = i + 1
  end
end

local function config_marks()
  -- customise the signs used for marks
  local utils = require("marks.utils")
  local utf8 = require("core.utils.utf8")
  local lmarks = "ⓐⓑⓒⓓⓔⓕⓖⓗⓘⓙⓚⓛⓜⓝⓞⓟⓠⓡⓢⓣⓤⓥⓦⓧⓨⓩ"
  local umarks = "ⒶⒷⒸⒹⒺⒻⒼⒽⒾⒿⓀⓁⓂⓃⓄⓅⓆⓇⓈⓉⓊⓋⓌⓍⓎⓏ"
  local nmarks = "⓪①②③④⑤⑥⑦⑧⑨"

  add_marks(utf8, utils.sign_cache, lmarks, "a")
  add_marks(utf8, utils.sign_cache, umarks, "A")
  add_marks(utf8, utils.sign_cache, nmarks, "0")
  add_mark(utils.sign_cache, "❰", "<")
  add_mark(utils.sign_cache, "❱", ">")
  add_mark(utils.sign_cache, "", "^")
  add_mark(utils.sign_cache, "⨀", ".")
end

local M = {
  "chentoast/marks.nvim",
  config = function()
    require("marks").setup({
      default_mappings = false, -- turn off key mappings
      builtin_marks = { ".", "<", ">", "^" },
      cyclic = true,
      force_write_shada = false,
      refresh_interval = 250,
      sign_priority = { lower = 10, upper = 15, builtin = 8, bookmark = 20 },
      excluded_filetypes = {},
      mappings = {},
    })
    config_marks()
  end,
}

return M
