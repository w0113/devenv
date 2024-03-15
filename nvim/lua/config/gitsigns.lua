local map = vim.api.nvim_buf_set_keymap
local default_options = {noremap = true, silent = true}

require('gitsigns').setup({
  on_attach = function(bufnr)
    map(bufnr, 'n', '<leader>gh', ':lua require("gitsigns").preview_hunk()<CR>', default_options)
  end
})
