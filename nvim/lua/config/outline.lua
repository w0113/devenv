local map = vim.keymap.set
local default_options = {noremap = true, silent = true}

require("symbols-outline").setup()

map('n', '<leader><leader>o', ':SymbolsOutline<CR>', default_options)
