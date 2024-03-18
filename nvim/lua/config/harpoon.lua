local map = vim.keymap.set
local default_options = {noremap = true, silent = true}

local harpoon = require('harpoon')
harpoon:setup()

map('n', '<leader>a', function()
  harpoon:list():append()
  print('Added "' .. vim.fn.expand('%:.') .. '" to harpoon')
end, default_options)
map('n', '<leader><leader>h', function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, default_options)

map('n', 'sj', function() harpoon:list():select(1) end, default_options)
map('n', 'sk', function() harpoon:list():select(2) end, default_options)
map('n', 'sl', function() harpoon:list():select(3) end, default_options)
map('n', 'sö', function() harpoon:list():select(4) end, default_options)

-- Toggle previous & next buffers stored within Harpoon list
--map('n', '<C-S-P>', function() harpoon:list():prev() end, default_options)
--map('n', '<C-S-N>', function() harpoon:list():next() end, default_options)
