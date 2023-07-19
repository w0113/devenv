local map = vim.keymap.set
local default_options = {noremap = true, silent = true}

require('buffer_browser').setup {}

map('n', '<leader>n', require("buffer_browser").next, default_options)
map('n', '<leader>p', require("buffer_browser").prev, default_options)
