local map = vim.keymap.set
local default_options = {noremap = true, silent = true}

require('treesj').setup {
  use_default_keymaps = false,
}

map('n', '<leader>m', ':TSJToggle', default_options)
