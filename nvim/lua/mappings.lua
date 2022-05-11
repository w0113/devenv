local map = vim.keymap.set
default_options = {silent = true}

-- Remap space as leader key.
map({'n', 'v'}, '<Space>', '<Nop>', default_options)
vim.g.mapleader = ' '

-- Spell checking
vim.g.spelllang = 'en_us'
map('n', '<leader><leader>s', ':set spelllang=en_us spell!<CR>', default_options)
map('n', '<leader><leader>d', ':set spelllang=de_de spell!<CR>', default_options)

-- Use jj as alternative for escape.
map('i', 'jj', '<ESC>', default_options)

-- Paste over currently selected text without yanking it
map("v", "p", '"_dP', default_options)

-- Switch to last buffer.
map('n', '<leader><leader>b', ':b#<CR>', default_options)

-- Use leader+m for jumping to marks.
map({'n', 'x'}, '<leader>m', '`', default_options)

-- Clear search highlights.
map('n', '<ESC><ESC>', '<ESC>:nohlsearch <bar> match none <bar> 2match none<CR>', default_options)

-- Move current or selected lines up and down.
map('n', 'Ä', ':m .+1<CR>==', default_options)
map('n', 'Ü', ':m .-2<CR>==', default_options)
map('x', 'Ä', ":m '>+1<CR>gv=gv", default_options)
map('x', 'Ü', ":m '<-2<CR>gv=gv", default_options)

-- Mappings for quickfix
map('n', '<leader>j', ':cnext <bar> normal zz<CR>', default_options)
map('n', '<leader>k', ':cprevious <bar> normal zz<CR>', default_options)

-- Mappings for resizing windows.
map('', '<Left>', '<C-w><', default_options)
map('', '<Down>', '<C-w>-', default_options)
map('', '<Up>', '<C-w>+', default_options)
map('', '<Right>', '<C-w>>', default_options)

-- Mappings for moving windows.
map('n', '<leader><Left>', '<C-w>H')
map('n', '<leader><Down>', '<C-w>J')
map('n', '<leader><Up>', '<C-w>K')
map('n', '<leader><Right>', '<C-w>L')

-- Mappings for switching windows.
map('n', '<C-h>', '<C-w>h', default_options)
map('n', '<C-j>', '<C-w>j', default_options)
map('n', '<C-k>', '<C-w>k', default_options)
map('n', '<C-l>', '<C-w>l', default_options)

-- Execute line
map('n', '!b', '!!bash<CR>', default_options)
map('n', '!r', '!!ruby<CR>', default_options)

-- Toggle listchars
map('n', '<leader><leader>l', ':set list!<CR>', default_options)

-- Also enable navigation mappings in neovims terminal.
map('t', '<C-h>', '<C-\\><C-n><C-w>h', default_options)
map('t', '<C-j>', '<C-\\><C-n><C-w>j', default_options)
map('t', '<C-k>', '<C-\\><C-n><C-w>k', default_options)
map('t', '<C-l>', '<C-\\><C-n><C-w>l', default_options)

-- Also enable mappings for resizing windows.
map('t', '<Left>', '<C-w><', default_options)
map('t', '<Down>', '<C-w>-', default_options)
map('t', '<Up>', '<C-w>+', default_options)
map('t', '<Right>', '<C-w>>', default_options)

-- Use leader+escape to leave terminal mode.
map('t', '<leader><ESC>', '<C-\\><C-n>', default_options)
