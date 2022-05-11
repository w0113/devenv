local map = vim.keymap.set
default_options = {remap = true, silent = true}

vim.g['sneak#label'] = 1
vim.g['sneak#absolute_dir'] = 1

map('n', '<leader>w', 'H0<Plug>Sneak_s', default_options)
map('n', '<leader>W', 'L$<Plug>Sneak_S', default_options)
