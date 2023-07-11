local map = vim.keymap.set
local default_options = {noremap = true, silent = true}

map('n', '<leader>r', ':FlutterHotReload<CR>', default_options)

vim.api.nvim_create_user_command('FlutterEmulatorsLaunchDefault', 'FlutterEmulatorsLaunch Pixel_5_API_33', {})
