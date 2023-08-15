# Ant's neovim config

Now 100% Lua and nicely modularised.

# Plugins 
Here's a list of the plugins I've added and their key bindings / commands, which I will never remember:

## Lazy.nvim

Lazy package and dependency manager. Use `:Lazy` to see what it's up to.

## Mason.nvim

It installs LSP servers, linters, formatters, and DAP plugins. Puts its binaries in ~/.local/share/nvim/mason/bin/ and adds them to neovim's PATH.

## Lsp / lspconfig

Load and configure LSP language servers for various languages, on an as-needed basis.

|key|binding|
|---|-------|
|<leader>li     |LSP info|
|<leader>ll     |line diagnostic -> more info|
|<leader>ln     |next diagnostic|
|<leader>lp     |previous diagnostic|
|<leader>lD     |goto Declaration|
|<leader>ld     |goto Definitions (Telescope)|
|<leader>lr     |goto References (Telescope)|
|<leader>lI     |goto Implementations (Telescope)|
|<leader>lt     |goto Type Definitions (Telescope)|
|<leader>ls     |Document's Symbols (Telescope)|
|<leader>le     |Document's Diagnostics (Telescope)|
|<leader>lws     |Workspace's Symbols (Telescope)|
|<leader>lwd     |Workspace's Diagnostics (Telescope)|
|<leader>lS     |function signature help (when on a function param)|
|C-k            |function signature help (when in INSERT mode)|
|<leader>lR     |rename|
|<leader>la     |Code Actions menu e.g. "git blame"|
|<leader>k      |show 'hover' info|
|<leader>lq     |Document's Diagnostics (QuickFix)|
|<leader>lwl    |List Workspace folders|
|<leader>lwa    |Add Workspace folder|
|<leader>lwr    |Remove Workspace folder|


## nvim-cmp

Handles all completion duties. In a cmp dialogue the following keys are bound:

|key |binding|
|----|-------|
|C-d | next  |
|C-u | prev  |
|C-SPACE| complete|
|C-e  | close |
|<CR>|Confirm|
|TAB, S-TAB | SuperTab emulation|

## null-ls

A fake language server: it allows non-LSP tools to interact with neovim via its LSP interface. Mostly used to run *formatters*.

## Treesitter

Provides parsers for various languages, so we can do AST-aware motions, textobjects etc. 

|textobject|description|
|----------|-----------|
|af        | around FUNCTION|
|IF        | in FUNCTION|
|ac        | around CLASS|
|ic        | in CLASS|
|al        | around LOOP|
|il        | in LOOP|
|ab        | around BLOCK|
|ib        | in BLOCK|
|ar        | around PARAMETER|
|ir        | in PARAMETER|

|key|binding|
|<leader>a | swap with next PARAMETER|
|<leader>A | swap with prev PARAMETER|
|]m        | next start FUNCTION|
|]]        | next start CLASS|
|]M        | next end FUNCTION|
|][        | next end CLASS|
|[m        | prev start FUNCTION|
|[[        | prev start CLASS|
|[M        | prev end FUNCTION|
|[]        | prev end CLASS|

## Telescope
Open Telescope with `:Telescope` which will cause it to lazy-load along with its dependencies.

One of these `native-fzf` is native and requires building: if that doesn't happen automatically, use Lazy's UI to build it with `gb`.




