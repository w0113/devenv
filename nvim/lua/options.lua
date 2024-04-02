local fn = vim.fn
local o = vim.opt

-- Basic settings
o.cmdheight = 2          -- Give more space for displaying messages.
o.fileencoding = 'utf-8' -- Write with this encoding.
o.lazyredraw = true      -- Do not redraw while executing macros etc.
o.shortmess:append('c')  -- Disable ins-completion-menu messages.
o.shortmess:append('I')  -- Disable intro message when starting vim.
o.termguicolors = true   -- Allow better color support.
o.timeoutlen = 750       -- Timeout for key combinations (in ms).
o.ttimeoutlen = 0        -- Timeout for <ESC> key (in ms).
o.updatetime = 300       -- Write swap file after this many milliseconds.

-- Write undo files.
o.undofile = true
o.undodir = fn.stdpath('data') .. '/undodir'

-- Enhance usability.
o.completeopt = {'menu', 'menuone', 'noselect'}
o.ignorecase = true    -- Do case insensitive matching.
o.inccommand = 'split' -- Also show off-screen substitute effects in a preview window.
o.isfname:remove('=')  -- Do not recognize '=' as part of a file name.
o.mouse = 'a'          -- Enable mouse usage (all modes).
o.showmatch = true     -- Show matching brackets.
o.signcolumn = 'yes'   -- Always show sign column.
o.smartcase = true     -- Do smart case matching.
o.textwidth = 120      -- Maximum width of text before wrapping.

-- Indentation and tab options.
o.breakindent = true
o.smartindent = true
o.tabstop = 2
o.softtabstop = 2
o.shiftwidth = 2
o.expandtab = true

-- Visual aids.
o.colorcolumn = '+1'
o.cursorline = true
o.number = true
o.relativenumber = true
o.scrolloff = 5
o.showmode = false

-- Folding.
o.foldenable = false -- Disable folding, enable with 'zi'.
o.foldmethod = 'expr'
o.foldexpr = 'nvim_treesitter#foldexpr()'

-- Listchars
o.listchars = {eol = '¶', tab = '‣ ', space = '·', trail = '·', extends = '»', precedes = '«', nbsp = '␣'}

-- Splits
o.splitright = true
o.splitbelow = false

-- Don't write history files with netrw.
vim.g.netrw_dirhistmax = 0
