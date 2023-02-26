local api = vim.api

-- highlight on yank  -  see `:help vim.highlight.on_yank()`
local highlight_group = api.nvim_create_augroup('YankHighlight', { clear = true })

api.nvim_create_autocmd('TextYankPost', {
    callback = function()
        vim.highlight.on_yank { timeout = 500 }
    end,
    group = highlight_group,
    pattern = '*',
})

