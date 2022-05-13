local map = vim.keymap.set
default_options = {silent = true}

require('nvim-tree').setup {
  view = {
    width = 40,
    mappings = {
      list = {
        {key = '<C-k>', action = ''},
        {key = 'i', action = 'toggle_file_info'}
      }
    }
  },
  filters = {
    dotfiles = true
  }
}

map('n', '<leader><leader>n', ':NvimTreeToggle<CR>', default_options)