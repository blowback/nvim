-- Mason isntalls stuff to stdpath('data')/mason [:echo stdpath('data')]
-- Executables are linked to a single bin/ directory which Mason.nvim adds
-- to the NeoVim PATH during setup, allowing easy access for the builtin
-- shell/terminal as well as other 3rd party plugins.
local settings = require("core.settings")

local M = {
  "williamboman/mason.nvim",
  --event = "VeryLazy",
  dependencies = {
    { "williamboman/mason-lspconfig.nvim", module = "mason" },
  },
  config = function()
    -- install_root_dir = path.concat({ vim.fn.stdpath("data"), "mason" }),
    require("mason").setup()

    -- ensure tools (except LSPs) are installed
    local mr = require("mason-registry")
    local function install_ensured()
      for _, tool in ipairs(settings.tools) do
        local p = mr.get_package(tool)
        if not p:is_installed() then
          p:install()
        end
      end
    end
    if mr.refresh then
      mr.refresh(install_ensured)
    else
      install_ensured()
    end

    -- install LSPs
    require("mason-lspconfig").setup({ ensure_installed = settings.lsp_servers })
  end,
}

return M
