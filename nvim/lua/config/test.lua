local map = vim.keymap.set
local default_options = {noremap = true, silent = true}

vim.g.dispatch_no_maps = 1
vim.g['test#strategy'] = 'dispatch'

map('n', '<leader>ta', ':TestSuite<CR>', default_options)
map('n', '<leader>tf', ':TestFile<CR>', default_options)
map('n', '<leader>tn', ':TestNearest<CR>', default_options)
map('n', '<leader>tt', ':TestLast<CR>', default_options)
map('n', '<leader>tv', ':TestVisit<CR>', default_options)
map('n', '<leader>tc', ':cclose<CR>', default_options)
map('n', '<leader>to', ':copen<CR>', default_options)
