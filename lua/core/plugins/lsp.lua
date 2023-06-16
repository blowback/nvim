-- collection of configurations for built-in lsp client
local M = {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    { "onsails/lspkind-nvim" },
  },
  config = function()
    require("core.plugins.lsp.lsp")
  end,
}

-- set up some signs for LSP diagnostics
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }

for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

return M
