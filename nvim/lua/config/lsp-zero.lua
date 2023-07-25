local map = vim.keymap.set
local default_options = {noremap = true, silent = true}

require('mason').setup {}
require('mason-lspconfig').setup {
  ensure_installed = {
    'bashls',
    'cssls',
    'html',
    'lua_ls',
    'solargraph',
    'tsserver',
    'yamlls'
  }
}

local lsp = require('lsp-zero').preset({})
local lsp_config = require('lspconfig')

lsp.on_attach(function(_, bufnr)
  lsp.default_keymaps({buffer = bufnr})
end)

-- Manually configure LSP servers:
lsp_config.lua_ls.setup(lsp.nvim_lua_ls())
if vim.fn.executable('dart') == 1 then
  lsp_config.dartls.setup({})
end

lsp.setup()

local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()

require('luasnip.loaders.from_vscode').lazy_load()

cmp.setup({
  sources = {
    {name = 'path'},
    {name = 'copilot'},
    {name = 'nvim_lsp'},
    {name = 'buffer', keyword_length = 3},
    {name = 'luasnip', keyword_length = 2},
  },
  mapping = {
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-f>'] = cmp_action.luasnip_jump_forward(),
    ['<C-b>'] = cmp_action.luasnip_jump_backward(),
    ['<CR>'] = cmp.mapping.confirm({
      -- documentation says this is important. I don't know why.
      behavior = cmp.ConfirmBehavior.Replace,
      select = false,
    }),
  }
})

map('n', '<leader><leader>e',
  function()
    local config = vim.diagnostic.config()
    config['virtual_text'] = not config['virtual_text']
    vim.diagnostic.config(config)
  end,
  default_options)
