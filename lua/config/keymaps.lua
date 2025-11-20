-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

-- select last pasted region
map("", "gp", function()
  local visual = vim.fn.getregtype()
  local cmd = ":normal `[" .. visual .. "`]"
  vim.api.nvim_exec2(cmd, { output = false })
end)
