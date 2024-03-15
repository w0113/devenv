local api = vim.api

-- Set filetype specific options.
local filetype_settings = api.nvim_create_augroup('filetype_settings', {clear = true})
api.nvim_create_autocmd('FileType', {
    pattern = {'todo'},
    command = 'setlocal noautoindent nosmartindent',
    group = filetype_settings
  }
)
