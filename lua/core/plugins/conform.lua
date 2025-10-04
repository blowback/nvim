-- conform is a formatter plugin.
-- eg prettier, prettierd, stylua, isort, black, rstfmt
local M = {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	keys = {
		{
			-- Customize or remove this keymap to your liking
			"<leader>f",
			function()
				require("conform").format({ async = true, lsp_fallback = true })
			end,
			mode = "",
			desc = "Format buffer",
		},
	},
	-- Everything in opts will be passed to setup()
	opts = {
		-- Define your formatters
		formatters_by_ft = {
			lua = { "styluaX" },
			-- run isort and black sequentially
			python = { "isort", "black" },
			-- run only the first available of prettierd, prettier
			javascript = { "prettierd", "prettier" },
		},

		-- Set up format-on-save
		-- format_on_save = { timeout_ms = 500, lsp_fallback = true },

		-- Customize formatters
		formatters = {
			shfmt = {
				prepend_args = { "-i", "2" },
			},
			prettier = {
				prepend_args = { "--tab-width", 4 },
			},
			prettierd = {
				env = {
					PRETTIERD_DEFAULT_CONFIG = vim.fn.expand("~/.config/nvim/utils/linter-config/.prettierrc.json"),
				},
			},
		},
	},
}

return M
