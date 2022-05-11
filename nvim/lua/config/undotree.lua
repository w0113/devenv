local map = vim.keymap.set
default_options = {silent = true}

map('n', '<leader><leader>u', ':UndotreeToggle<CR>', default_options)
