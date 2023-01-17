-- Learn the keybindings, see :help lsp-zero-keybindings
-- Learn to configure LSP servers, see :help lsp-zero-api-showcase

local lsp = require('lsp-zero')
lsp.preset('recommended')

-- make sure this servers are installed
-- see :help lsp-zero.ensure_installed()
lsp.ensure_installed({
  'bashls',
  'cssls',
  'html',
  'solargraph',
  'tsserver',
  'yamlls'
})

lsp.setup()
