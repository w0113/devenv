local map = vim.keymap.set
local default_options = {noremap = true, silent = true}

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'fugitive',
  callback = function()
    map('n', 'dt', ':Gtabedit <Plug><cfile><Bar>Gvdiffsplit!<CR>', {noremap = false, silent = true})
  end
})
-- Pull in changes from left side
map('n', '<leader>df', ':diffget //2<CR>', default_options)
-- Pull in changes from right side
map('n', '<leader>dj', ':diffget //3<CR>', default_options)
-- Update diff
map('n', '<leader>du', ':diffupdate<CR>', default_options)
