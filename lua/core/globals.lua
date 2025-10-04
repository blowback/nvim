local ok, plenary_reload = pcall(require, "plenary.reload")

if not ok then
  RELOADER = require
else
  RELOADER = plenary_reload.reload_module
end

RELOAD = function(...)
  return RELOADER(...)
end

-- Reload a module
R = function(name)
  RELOAD(name)
  return require(name)
end

-- Print the string representation of a Lua table
P = function(v)
  print(vim.inspect(v))
  return v
end

-- customise the signs used for marks
-- local utf8 = require("core.utils.utf8")
-- local lmarks = "ⓐⓑⓒⓓⓔⓕⓖⓗⓘⓙⓚⓛⓜⓝⓞⓟⓠⓡⓢⓣⓤⓥⓦⓧⓨⓩ"
-- local umarks = "ⒶⒷⒸⒹⒺⒻⒼⒽⒾⒿⓀⓁⓂⓃⓄⓅⓆⓇⓈⓉⓊⓋⓌⓍⓎⓏ"
-- local nmarks = "⓪①②③④⑤⑥⑦⑧⑨"
-- local testmarks = "ⓐbcdefghijklmnopqrstuvwxyz"
--
-- local function add_marks(marks, initial)
--   local b = string.byte(initial)
--   local i = 1
--   for p, c in utf8.codes(marks) do
--     --local c = utf8.char(c)
--     local n = string.char(b + i - 1)
--     i = i + 1
--     vim.fn.sign_define("Marks_" .. n, { text = c, texthl = "MarkSignHL", numhl = "MarkSignNumHL" })
--   end
-- end
-- add_marks(lmarks, "a")
diagnostics = {
    [vim.diagnostic.severity.ERROR]= { name = "ERROR", text = "󰅙", hl = "DiagnosticSignError" },
    [vim.diagnostic.severity.WARN] = { name = "WARN", text = "", hl = "DiagnosticSignWarn" },
    [vim.diagnostic.severity.HINT] = { name = "HINT", text = "", hl = "DiagnosticSignHint" },
    [vim.diagnostic.severity.INFO] = { name = "INFO", text = "󰋼", hl = "DiagnosticSignInfo" },
}

local severity = vim.diagnostic.severity

local signs = {
    text = {},
    linehl = {},
    numhl = {},
}

for _, level in pairs(diagnostics) do
    signs.text[severity[level.name]] = level.text
    signs.linehl[severity[level.name]] = "" -- level.hl
    signs.numhl[severity[level.name]] = level.hl
end

vim.diagnostic.config({ signs = signs })

