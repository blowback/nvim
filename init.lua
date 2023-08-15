--  ant's .vimrc multi-platform 3.0   23/10/2008
--                              3.1   14/01/2009
--                              3.2   21/10/2010
--                              3.3   22/02/2011
--                              3.4   24/02/2011
--                              3.5   13/04/2012
--                              3.6   10/06/2015
--                              3.7   10/03/2021
--  ant's neovim init.lua       3.8   24/06/2022 based on https://github.com/nvim-lua/kickstart.nvim
--                              3.9   23/02/2023 unicode signs, cmp icons
--                              3.10  24/02/2023 modularize: based on https://github.com/Allaman/nvim
--                                                                and https://gist.github.com/benfrain/97f2b91087121b2d4ba0dcc4202d252f
--                              3.11  16/06/2023 up to date wrt Allaman 7a9b7213b0bafeff942eeecdb18c6549df3f40ea
require("core.globals")
require("core.lazy")
require("core.mappings")
require("core.options")
require("core.autocmd")
