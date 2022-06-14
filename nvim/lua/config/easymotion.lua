local map = vim.keymap.set
local default_options = {noremap = true, silent = true}

map('n', '<leader>f', '<Plug>(easymotion-s)', default_options)
map('n', '<leader>F', '<Plug>(easymotion-s)', default_options)
map('n', '<leader>w', '<Plug>(easymotion-bd-w)', default_options)
map('n', '<leader>W', '<Plug>(easymotion-bd-W)', default_options)
map('n', '<leader>e', '<Plug>(easymotion-bd-e)', default_options)
map('n', '<leader>E', '<Plug>(easymotion-bd-E)', default_options)

vim.g.EasyMotion_keys = 'asdklöqwertzuiopyxcvbnm,.-fghj'
