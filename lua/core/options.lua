local settings = require("core.settings")
local utils = require("core.utils.functions")
local o = vim.opt
local wo = vim.wo
local fn = vim.fn


-- [[ tab settings ]]
o.tabstop = 4 -- num. spaces used to represent tab in the file
o.shiftwidth = 4 -- num. spaces for horizontal shift, 0 => same as tabstop (deprecated)
o.expandtab = true -- insert mode tab -> spaces

-- [[ indentation setup ]]
o.fileformats = "unix,mac,dos" -- auto line-ending detection, prefer unix
o.suffixes = ".lo,.o,.moc,.la,.closure" -- exclude from file completion
--o.cindent=true
--o.smartindent=true
--o.autoindent=true
--o.cinoptions=">s,e0,n0,f0,{0,}0,^0,:s,cs,=s,gs,hs,ps,ts,+0,(s,)s,us,*30,+s"
--set vim.o.comments=sr:/*,mb:*,el:*/,://,b:*,b:#,:%,:xcomm,n:>,fb:-")

-- [[ misc behaviour settings ]]
o.hidden = false -- no emacs-style buffer hiding
o.regexpengine = 2 -- new fast nfa engine
o.whichwrap = "b,s,<,>,[,]" -- allow left/right/bs/spc to move across line boundaries
--o.wildmode="longest,list" -- bash-like filename completion
o.wildmode = "full" -- enable 'wildmenu'
o.updatetime = 250 -- make cursorhold plugins a bit more responsive
o.mouse = 'a' -- enable mouse in all modes
o.breakindent = true -- indent wrapped lines
o.undofile = true -- save undo history
wo.signcolumn = 'yes'

-- [[ search settings ]]
o.hlsearch = true -- highlight current search pattern
o.incsearch = true -- incremental searching
o.ignorecase = true -- ignore case in a search...
o.smartcase = true -- ...unless it has /c or capitals
o.infercase = true -- alter search string to match case in ins mode completion
o.showcmd = true -- show visual selection mode in last line
o.showmode = true -- show insert, visual etc in last line
o.report = 0 -- always report how many lines were changed

-- [[ folding settings ]]
o.foldenable = true -- folding is annoying, but let's give lsp a chance

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
o.formatoptions = "jcql"

-- [[ appearance settings ]]
o.scrolloff = 0 -- lines of context above/below cursor
o.title = true -- set window title to vim info
o.laststatus = 2 -- status line always present
o.ruler = true -- line/col in status
o.showbreak = "> " -- char used to indicate split lines
o.number = true -- line numbers (current line only, see next)
o.relativenumber = true -- relative numbers for non current line
o.startofline = false -- keep cursor where it is when moving up/down
o.showmatch = true -- flash matching parens
o.matchtime = 10 -- for this many 10ths of a second
o.shortmess = "aoOtTAWI" -- restrict annoying "enter to continue" msgs as far as poss
o.listchars = "tab:>-,trail:-" -- set display chars in "list-mode"
o.cursorline = true -- hightlight the line the cursor is on, cf 'cursorcolumn'

-- [[ list mode settings ]]
o.list = true
o.listchars = "tab:┊┈,trail:…,extends:►,precedes:◄,nbsp:˽"

-- [[ error/make/quickfix settings ]]
o.errorformat = "%-Dmake: Entering directory `%f'"
vim.opt.errorformat:append {
    "%-Xmake: Leaving directory `%f'",
    "%-G%f: In function %m",
    "%-GCompiling %f%m",
    "%-G(Dependencies %f)",
    "%-G%f:%l: error: (Each undeclared identifier is reported only once",
    "%-G%f:%l: error: for each function it appears in.)",
    "%f:%l:%m",
}

o.makeprg = "./make.sh"
o.shellpipe = "2>&1 >"

-- [[ colour scheme settings ]]
o.termguicolors = true -- 24bit color in tui. uses "gui" highlights over "cterm"

-- [[ printing settings ]]
-- print small, landscape, duplex
-- vim.o.printfont = "Courier:h8"
-- vim.o.printoptions = "paper:A4,syntax:y,wrap:y,duplex:long,portrait:n"

-- set completeopt to have a better completion experience
o.completeopt = 'menuone,noselect'





















