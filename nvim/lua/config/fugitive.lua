local map = vim.keymap.set
local default_options = {buffer = true, noremap = true, silent = true}

-- Mappings for fugitive buffers.
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'fugitive',
  callback = function()
    -- Open file under cursor in diff mode in separate tab
    map('n', 'dt', ':Gtabedit <Plug><cfile><Bar>Gvdiffsplit!<CR>', default_options)
  end
})

-- Mappings for diff buffers.
vim.api.nvim_create_autocmd('BufEnter', {
  callback = function()
    if vim.o.diff then
      -- Jump to next change
      map('n', '<leader>j', ']c', default_options)
      -- Jump to previous change
      map('n', '<leader>k', '[c', default_options)
      -- Pull in changes from left side
      map('n', '<leader>g', ':diffget //2<CR>', default_options)
      -- Pull in changes from right side
      map('n', '<leader>h', ':diffget //3<CR>', default_options)
      -- Update diff
      map('n', '<leader>u', ':diffupdate<CR>', default_options)
    end
  end
})
