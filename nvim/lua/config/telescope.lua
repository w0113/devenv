local map = vim.keymap.set
default_options = {silent = true}

require('telescope').setup()
require('telescope').load_extension('fzf')

map('n', 'ss', ':Telescope find_files<CR>', default_options)
map('n', 'sa', ':Telescope live_grep<CR>', default_options)
map('n', 'sb', ':Telescope buffers<CR>', default_options)
map('n', 'sh', ':Telescope help_tags<CR>', default_options)

map('n', 'sq', ':lua require("telescope.builtin").quickfix()<CR>', default_options)
map('n', 'sg', ':lua require("telescope.builtin").git_files()<CR>', default_options)
