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

-- toggle comment in insert mode
map("i", "<c-/>", require("Comment.api").toggle.linewise.current)
