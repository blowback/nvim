local utils = require("core.utils.functions")
local map = vim.keymap.set

-- <m-up> etc don't work in terminal, but <s-up> and <c-up> do
-- c-\ c-n temp switch to normal mode
map("", "<c-up>", "<c-\\><c-n>:bp<cr>")
map("", "<c-down>", "<c-\\><c-n>:bn<cr>")
map("", "<c-left>", "<c-\\><c-n>:tabp<cr>")
map("", "<c-right>", "<c-\\><c-n>:tabn<cr>")

-- wny isn't this a mapping? because it works in INSERT even when 'paste' is on
vim.o.pastetoggle = "<F10>"

-- select last pasted region
map("", "gp", function()
  local visual = vim.fn.getregtype()
  local cmd = ":normal `[" .. visual .. "`]"
  vim.api.nvim_exec(cmd, false)
end)

-- navigate prev/next errors
map("", "<c-N>", "<c-\\><c-n>:cn<cr>")
map("", "<c-P>", "<c-\\><c-n>:cp<cr>")

-- Cancel search highlighting with ESC
map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Clear hlsearch and ESC" })

-- toggle comment in insert mode
map("i", "<c-/>", require("Comment.api").toggle.linewise.current)

-- toggles
map("n", "<leader>th", function()
  utils.notify("Toggling hidden chars", vim.log.levels.INFO, "core.mappings")
  vim.o.list = vim.o.list == false and true or false
end, { desc = "Toggle hidden chars" })

map("n", "<leader>tl", function()
  utils.notify("Toggling signcolumn", vim.log.levels.INFO, "core.mappings")
  vim.o.signcolumn = vim.o.signcolumn == "yes" and "no" or "yes"
end, { desc = "Toggle signcolumn" })

map("n", "<leader>tv", function()
  utils.notify("Toggling virtualedit", vim.log.levels.INFO, "core.mappings")
  vim.o.virtualedit = vim.o.virtualedit == "all" and "block" or "all"
end, { desc = "Toggle virtualedit" })

map("n", "<leader>ts", function()
  utils.notify("Toggling spell", vim.log.levels.INFO, "core.mappings")
  vim.o.spell = vim.o.spell == false and true or false
end, { desc = "Toggle spell" })

map("n", "<leader>tw", function()
  utils.notify("Toggling wrap", vim.log.levels.INFO, "core.mappings")
  vim.o.wrap = vim.o.wrap == false and true or false
end, { desc = "Toggle wrap" })

map("n", "<leader>tc", function()
  utils.notify("Toggling cursorline", vim.log.levels.INFO, "core.mappings")
  vim.o.cursorline = vim.o.cursorline == false and true or false
end, { desc = "Toggle cursorline" })

map(
  "n",
  "<leader>to",
  "<cmd>lua require('core.utils.functions').toggle_colorcolumn()<cr>",
  { desc = "Toggle colorcolumn" }
)

map(
  "n",
  "<leader>tt",
  "<cmd>lua require('core.plugins.lsp.utils').toggle_virtual_text()<cr>",
  { desc = "Toggle Virtualtext" }
)
map("n", "<leader>ts", "<cmd>SymbolsOutline<cr>", { desc = "Toggle SymbolsOutline" })
