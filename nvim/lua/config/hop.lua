local map = vim.keymap.set
local default_options = {noremap = true, silent = false}

require('hop').setup {
  keys = 'asdklöqwertzuiopyxcvbnm,.fghj'
}

map('n', '<leader>f', ':HopChar1MW<CR>', default_options)
map('n', '<leader>F', ':HopChar1<CR>', default_options)
map('n', '<leader>w', ':HopWordMW<CR>', default_options)
map('n', '<leader>W', ':HopWord<CR>', default_options)
map('n', '<leader>/', ':HopPattern<CR>', default_options)
