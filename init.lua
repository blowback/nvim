--  ant's .vimrc multi-platform 3.0 23/10/2008
--                              3.1 14/01/2009
--                              3.2 21/10/2010
--                              3.3 22/02/2011
--                              3.4 24/02/2011
--                              3.5 13/04/2012
--                              3.6 10/06/2015
--                              3.7 10/03/2021
--  ant's neovim init.lua       3.8 24/06/2022 based on https://github.com/nvim-lua/kickstart.nvim

-- install packer
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
local is_bootstrap = false

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  is_bootstrap = true
  vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
  vim.cmd [[packadd packer.nvim]]
end

-- stylua: ignore start
local packer = require('packer')
packer.startup(function(use)
  use 'wbthomason/packer.nvim'                                                    -- package manager
  use 'tpope/vim-fugitive'                                                        -- git commands in nvim
  use 'tpope/vim-rhubarb'                                                         -- fugitive-companion to interact with github
  use { 'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' } }       -- add git related info in the signs columns and popups
  use 'numToStr/Comment.nvim'                                                     -- "gc" to comment visual regions/lines
  use 'nvim-treesitter/nvim-treesitter'                                           -- highlight, edit, and navigate code
  use 'nvim-treesitter/nvim-treesitter-textobjects'                               -- additional textobjects for treesitter
  use 'neovim/nvim-lspconfig'                                                     -- collection of configurations for built-in lsp client
  use 'williamboman/nvim-lsp-installer'                                           -- automatically install language servers to stdpath
  use { 'hrsh7th/nvim-cmp', requires = {                                          -- autocompletion
    { 'hrsh7th/cmp-nvim-lsp' },                                                   -- autocompletion from lsp
    { 'hrsh7th/cmp-buffer' },                                                     -- autocompletion from curernt buffer words
    { 'hrsh7th/cmp-path' },                                                       -- autocompletion for paths 
    { 'hrsh7th/cmp-cmdline' },                                                    -- autocompletion for command line
  }}
  use { 'L3MON4D3/LuaSnip', requires = { 'saadparwaiz1/cmp_luasnip' } }           -- snippet engine and snippet expansion
  use 'mjlbach/onedark.nvim'                                                      -- theme inspired by atom
  use 'shaunsingh/nord.nvim'                                                      -- nord theme, with treesitter support
  use 'nvim-lualine/lualine.nvim'                                                 -- fancier statusline
  use 'lukas-reineke/indent-blankline.nvim'                                       -- add indentation guides even on blank lines
  use 'tpope/vim-sleuth'                                                          -- detect tabstop and shiftwidth automatically
  use { 'nvim-telescope/telescope.nvim', requires = { 'nvim-lua/plenary.nvim' } } -- fuzzy finder (files, lsp, etc)

  -- fuzzy finder algorithm which requires local dependencies to be built. only load if `make` is available
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make', cond = vim.fn.executable "make" == 1 }

  if is_bootstrap then
    packer.sync()
  end
end)
-- stylua: ignore end


-- when we are bootstrapping a configuration, it doesn't
-- make sense to execute the rest of the init.lua.
--
-- you'll need to restart nvim, and then it will work.
if is_bootstrap then
  print '=================================='
  print '    Plugins are being installed'
  print '    Wait until Packer completes,'
  print '       then restart nvim'
  print '=================================='
  return
end

-- automatically source, and re-compile packer whenever you save this init.lua
-- kill existing lsp client, to stop us accumulating lsp processes
local packer_group = vim.api.nvim_create_augroup('Packer', { clear = true })
vim.api.nvim_create_autocmd('BufWritePost', {
  --command = 'source <afile> | packercompile',
  callback = function()
    local buf_num = vim.api.nvim_get_current_buf()
    local buf_file = vim.api.nvim_buf_get_name(buf_num)

    local stopLSPClient = function(client, client_id, bufnr)
      -- print(string.format("stopped lsp client id %d in buffer %d", client_id, bufnr))
      client.stop()
    end

    vim.lsp.for_each_buffer_client(buf_num, stopLSPClient)
    dofile(buf_file)
    packer.compile()
  end,
  group = packer_group,
  pattern = vim.fn.expand '$MYVIMRC',
})

-- [[ mapping options ]]
vim.g.mapleader = ','      -- global mapleader
vim.g.maplocalleader = ',' -- per-filetype mapleader

-- [[ tab settings ]]
vim.o.tabstop = 4       -- num. spaces used to represent tab in the file
vim.o.shiftwidth = 0    -- num. spaces for horizontal shift, 0 => same as tabstop (deprecated)
vim.o.expandtab = true  -- insert mode tab -> spaces

-- [[ 

-- [[ indentation setup ]]
vim.o.fileformats="unix,mac,dos" -- auto line-ending detection, prefer unix
vim.o.suffixes=".lo,.o,.moc,.la,.closure" -- exclude from file completion
--vim.o.cindent=true
--vim.o.smartindent=true
--vim.o.autoindent=true
--vim.o.cinoptions=">s,e0,n0,f0,{0,}0,^0,:s,cs,=s,gs,hs,ps,ts,+0,(s,)s,us,*30,+s"
--set vim.o.comments=sr:/*,mb:*,el:*/,://,b:*,b:#,:%,:xcomm,n:>,fb:-")

-- [[ misc behaviour settings ]]
vim.o.hidden = false   -- no emacs-style buffer hiding
vim.o.regexpengine = 2 -- new fast nfa engine
vim.o.whichwrap = "b,s,<,>,[,]" -- allow left/right/bs/spc to move across line boundaries
--vim.o.wildmode="longest,list" -- bash-like filename completion
vim.o.wildmode="full" -- enable 'wildmenu'
vim.o.updatetime = 250 -- make cursorhold plugins a bit more responsive
vim.o.mouse = 'a'       -- enable mouse in all modes
vim.o.breakindent = true -- indent wrapped lines
vim.o.undofile = true -- save undo history
vim.wo.signcolumn = 'yes'

-- [[ search settings ]]
vim.o.hlsearch = true   -- highlight current search pattern
vim.o.incsearch = true -- incremental searching
vim.o.ignorecase = true -- ignore case in a search...
vim.o.smartcase = true -- ...unless it has /c or capitals
vim.o.infercase = true -- alter search string to match case in ins mode completion
vim.o.showcmd = true -- show visual selection mode in last line
vim.o.showmode = true -- show insert, visual etc in last line
vim.o.report = 0      -- always report how many lines were changed

-- [[ folding settings ]]
vim.o.foldenable = true -- folding is annoying, but let's give lsp a chance

-- [[ formatting settings ]]
--                               c autowrap comments using textwidth
--                               r insert comment leader on <enter>
--                               o insert comment leader on o or o
--                               q gq formats comments
--                               n recognise numbered lists
--                               v wrap on blanks
--                               t autowrap text using textwidth
--                               w trailing whitespace => para continues in
--                                 next line
--                               a automatic paragraph formatting
--                               2 use indent of 2nd para indent_new_line
--                               v vi-compatible auto-wrapping in ins mode
--                               b like v, but only if you enter a blank at the wrap margin
--                               l long lines not broken in insert mode
--                               m break at multibyte chars above 255
--                               m don't insert space before or after mb char on join
--                               b don't insert space between two mb chars on join
--                               1 don't break a line after a one-letter word, break before
--                               ] respect textwidth rigourously
--                               j where it makes sense, remove comment leader on join
--                               p don't break lines at single spaces following periods
vim.o.formatoptions="jcql"
--

-- [[ appearance settings ]]
vim.o.scrolloff = 0        -- lines of context above/below cursor
vim.o.title = true         -- set window title to vim info 
vim.o.laststatus = 2       -- status line always present
vim.o.ruler = true         -- line/col in status 
vim.o.showbreak = "> "     -- char used to indicate split lines
vim.wo.number = false   -- line numbers
vim.o.startofline = false  -- keep cursor where it is when moving up/down
vim.o.showmatch = true      -- flash matching parens
vim.o.matchtime = 10        -- for this many 10ths of a second
vim.o.shortmess = "aoOtTAWI" -- restrict annoying "enter to continue" msgs as far as poss
vim.o.listchars = "tab:>-,trail:-" -- set display chars in "list-mode"
vim.o.cursorline = true     -- hightlight the line the cursor is on, cf 'cursorcolumn'

-- [[ list mode settings ]]
vim.o.list = true
vim.o.listchars = "tab:┊┈,trail:…,extends:►,precedes:◄,nbsp:˽"

-- [[ error/make/quickfix settings ]]
vim.o.errorformat = "%-Dmake: Entering directory `%f'"
vim.opt.errorformat:append {
    "%-Xmake: Leaving directory `%f'",
    "%-G%f: In function %m",
    "%-GCompiling %f%m",
    "%-G(Dependencies %f)",
    "%-G%f:%l: error: (Each undeclared identifier is reported only once",
    "%-G%f:%l: error: for each function it appears in.)",
    "%f:%l:%m",
}

vim.o.makeprg = "./make.sh"
vim.o.shellpipe = "2>&1 >"

-- [[ colour scheme settings ]] 
vim.o.termguicolors = true   -- 24bit color in tui. uses "gui" highlights over "cterm"
--vim.cmd [[colorscheme onedark]]
vim.cmd [[colorscheme nord]]

if vim.g.colors_name == "nord" then
    vim.g.nord_contrast = true
    vim.g.nord_borders = true
end

-- [[ printing settings ]]
-- print small, landscape, duplex
vim.o.printfont = "Courier:h8"
vim.o.printoptions = "paper:A4,syntax:y,wrap:y,duplex:long,portrait:n"

-- set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- [[ keymaps ]]

-- highlight on yank  -  see `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank { timeout = 500 }
  end,
  group = highlight_group,
  pattern = '*',
})

-- <m-up> etc don't work in terminal, but <s-up> and <c-up> do
-- c-\ c-n temp switch to normal mode
vim.keymap.set("", "<c-up>", "<c-\\><c-n>:bp<cr>")
vim.keymap.set("", "<c-down>", "<c-\\><c-n>:bn<cr>")
vim.keymap.set("", "<c-left>", "<c-\\><c-n>:tabp<cr>")
vim.keymap.set("", "<c-right>", "<c-\\><c-n>:tabn<cr>")

vim.o.pastetoggle = "<F10>"

-- select last pasted region
vim.keymap.set("", "gp", function()
    local visual = vim.fn.getregtype()
    local cmd = ":normal `[" .. visual .. "`]"
    vim.api.nvim_exec(cmd, false)
end)

-- navigate prev/next errors
vim.keymap.set("", "<c-N>", "<c-\\><c-n>:cn<cr>")
vim.keymap.set("", "<c-P>", "<c-\\><c-n>:cp<cr>")

-- set lualine as statusline see `:help lualine.txt`
require('lualine').setup {
  options = {
    icons_enabled = true,
    globalstatus = false, -- one statusline for all windows...weird
    always_divide_middle = true,
    theme = 'auto', -- attempt to load them for colorscheme, or fake one up
    component_separators = { left = '', right = ''},
		section_separators = { left = '', right = ''},
    sections = {
      lualine_a = { 'mode' },
      lualine_b = { 'branch', 'diff', 'diagnostics' },
      lualine_c = { 'filename' },
      lualine_x = { 'encoding', 'fileformat', 'filetype' },
      lualine_y = { 'progress' },
      lualine_z = { 'location' },
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = { 'filename' },
      lualine_x = { 'location' },
      lualine_y = {},
      lualine_z = {},
    },
  },
}

-- enable comment.nvim
require('Comment').setup()


-- enable `lukas-reineke/indent-blankline.nvim`
-- see `:help indent_blankline.txt`
require('indent_blankline').setup {
  char = '┊',
  show_trailing_blankline_indent = false,
}

-- gitsigns
-- see `:help gitsigns.txt`
require('gitsigns').setup {
  signs = {
    add = { text = '+' },
    change = { text = '~' },
    delete = { text = '_' },
    topdelete = { text = '‾' },
    changedelete = { text = '~' },
  },
}

-- [[ configure telescope ]]
-- see `:help telescope` and `:help telescope.setup()`
require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ['<c-u>'] = false,
        ['<c-d>'] = false,
      },
    },
  },
}

-- enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')

-- see `:help telescope.builtin`
vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>/', function()
  -- you can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] fuzzily search in current buffer]' })

vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })

-- [[ configure treesitter ]]
-- see `:help nvim-treesitter`
require('nvim-treesitter.configs').setup {
  -- add languages to be installed here that you want installed for treesitter
  ensure_installed = { 'c', 'cmake', 'cpp', 'css', 'dockerfile', 'dot', 'elixir', 'erlang', 'haskell', 'html', 'http', 'javascript', 'jsdoc', 'json', 'json5', 'julia', 'kotlin', 'lua', 'make', 'markdown', 'typescript', 'r', 'regex', 'rust', 'ruby', 'scss', 'sql', 'swift', 'go', 'python', 'vim' },

  highlight = { enable = true },
  indent = { enable = true },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<m-u>',
      node_incremental = '<m-u>',
      -- todo: i'm not sure for this one.
      scope_incremental = '<m-u>',
      node_decremental = '<m-d>',
    },
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true, -- automatically jump forward to textobj, similar to targets.vim
      keymaps = {
        -- you can use the capture groups defined in textobjects.scm
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        [']m'] = '@function.outer',
        [']]'] = '@class.outer',
      },
      goto_next_end = {
        [']M'] = '@function.outer',
        [']['] = '@class.outer',
      },
      goto_previous_start = {
        ['[m'] = '@function.outer',
        ['[['] = '@class.outer',
      },
      goto_previous_end = {
        ['[M'] = '@function.outer',
        ['[]'] = '@class.outer',
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ['<leader>a'] = '@parameter.inner',
      },
      swap_previous = {
        ['<leader>A'] = '@parameter.inner',
      },
    },
  },
}

-- diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)

vim.lsp.set_log_level("debug")
-- lsp settings.
--  this function gets run when an lsp connects to a particular buffer.
local on_attach = function(client, bufnr)
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

  nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
  nmap('gi', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
  nmap('gr', require('telescope.builtin').lsp_references)
  nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

  -- see `:help k` for why this keymap
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  nmap('<C-K>', vim.lsp.buf.signature_help, 'Signature Documentation')

  -- lesser used lsp functionality
  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
  nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd folder')
  nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove folder')
  nmap('<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, '[w]orkspace [l]ist folders')

  -- create a command `:format` local to the lsp buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', vim.lsp.buf.format or vim.lsp.buf.formatting, { desc = 'Format current buffer with LSP' })
end

-- nvim-cmp supports additional completion capabilities
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

-- enable the following language servers
local servers = { 'clangd', 'rust_analyzer', 'pyright', 'tsserver', 'sumneko_lua' }

-- ensure the servers above are installed
require('nvim-lsp-installer').setup {
  ensure_installed = servers,
}

-- do not call setup twice for the same server, says the docs
--[[ for _, lsp in ipairs(servers) do
  require('lspconfig')[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end ]]

-- make runtime files discoverable to the server
local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')

require('lspconfig').sumneko_lua.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
        path = runtime_path,
      },
      diagnostics = {
        globals = { "vim" },
        -- disable = { "lowercase-global" },
      },
      workspace = { library = vim.api.nvim_get_runtime_file('', true) },
      telemetry = { enable = false, },
    },
  },
}

require('lspconfig').clangd.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}

-- nvim-cmp setup
local cmp = require 'cmp'
local luasnip = require 'luasnip'

cmp.setup {
  -- must specify a snippet engine
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },

  window = {
    -- completion = cmp.config.window.bordered(),
    -- documentation = cmp.config.window.bordered()
  },

  mapping = cmp.mapping.preset.insert {
    ['<c-n>'] = cmp.mapping.select_next_item(),
    ['<c-p>'] = cmp.mapping.select_prev_item(),
    ['<c-b>'] = cmp.mapping.scroll_docs(-4), -- ajs doesn't seem to work currently
    ['<c-f>'] = cmp.mapping.scroll_docs(4), -- ajs doesn't seem to work currently
    ['<c-space>'] = cmp.mapping.complete(),
    ['<cr>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    -- supertab emulation
    ['<tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<s-tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  },

  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'buffer' },
  },
}

  -- use buffer source for `/` -- ajs this doesn't seem to work
  cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })

  -- use cmdline & path source for ':'
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })


-- luasnip setup
luasnip.config.set_config {
  history = true,                            -- remember the last used snippet so we can jump back to items
  updateevents = "TextChanged,TextChangedI", -- update as you type
  enable_autosnippets = true,
}

-- expand snippets with ctrl-k (insert mode, select mode)
vim.keymap.set({ "i", "s"}, "<c-k>", function()
  if luasnip.expand_or_jumpable() then
    luasnip.expand_or_jump()
  end
end, { silent = true })

-- move to previous item in a snippet with ctrl-j (insert mode, select mode)
vim.keymap.set({ "i", "s"}, "<c-j>", function ()
  if luasnip.jumpable(-1) then
    luasnip.jump(-1)
  end
end, { silent = true })

-- select from a list of options with ctrl-l (insert mode)
vim.keymap.set("i", "<c-l>", function()
  if luasnip.choice.active() then
    luasnip.change_choice(1)
  end
end)

-- the line beneath this is called `modeline`. see `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
