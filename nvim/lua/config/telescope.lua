local map = vim.keymap.set
local default_options = {noremap = true, silent = true}

require('telescope').setup()
require('telescope').load_extension('fzf')

map('n', 'st', ':Telescope<CR>', default_options)
map('n', 'ss', ':Telescope find_files<CR>', default_options)
map('n', 'sa', ':lua require("telescope.builtin").grep_string {only_sort_text = true, search = ""}<CR>', default_options)
map('n', 'sA', ':Telescope live_grep<CR>', default_options)
map('n', 'sb', ':Telescope buffers<CR>', default_options)
map('n', 'sh', ':Telescope help_tags<CR>', default_options)

map('n', 'sq', ':lua require("telescope.builtin").quickfix()<CR>', default_options)
map('n', 'sc', ':lua require("telescope.builtin").git_commits()<CR>', default_options)
map('n', 'sf', ':lua require("telescope.builtin").lsp_document_symbols()<CR>', default_options)
map('n', 'sF', ':lua require("telescope.builtin").lsp_workspace_symbols()<CR>', default_options)
map('n', 'sd', ':lua require("telescope.builtin").diagnostics()<CR>', default_options)
