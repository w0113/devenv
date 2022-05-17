local map = vim.keymap.set
local default_options = {noremap = true, silent = true}

map('n', '<leader><leader>u', ':UndotreeToggle<CR>', default_options)
