-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- remap leader to be COMMA, local leader to be SPACE
vim.g.mapleader = ","
vim.g.maplocalleader = " "

-- disable all irritating animations
vim.g.snacks_animate = false

local opt = vim.opt

opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 0
opt.expandtab = true
opt.smarttab = true
opt.wrap = true
