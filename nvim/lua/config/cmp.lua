local cmp = require('cmp')
local lspkind = require('lspkind')
local luasnip = require('luasnip')

cmp.setup {
  experimental = {
    ghost_text = true
  },
  formatting = {
    format = lspkind.cmp_format {
      mode = 'symbol_text',
      menu = {
        buffer = '[BUF]',
        luasnip = '[SNP]',
        nvim_lsp = '[LSP]',
        nvim_lua = '[LUA]',
        path = '[PTH]',
        spell = '[SPL]'
      }
    }
  },
  mapping = cmp.mapping.preset.insert {
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<C-z>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  },
  sources = cmp.config.sources {
    {name = 'nvim_lua'},
    {name = 'nvim_lsp'},
--    {name = 'luasnip'},
    {name = 'buffer'},
    {name = 'path'},
    {name = 'spell', keyword_length = 3, max_item_count = 5}
  }
}

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    {name = 'buffer'}
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    {name = 'path'}
  }, {
    {name = 'cmdline'}
  })
})

-- Setup lspconfig.
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
--capabilities.textDocument.completion.completionItem.snippetSupport = true

require('lspconfig')['solargraph'].setup {capabilities = capabilities}
require('lspconfig')['html'].setup {capabilities = capabilities}
require('lspconfig')['cssls'].setup {capabilities = capabilities}
require('lspconfig')['tsserver'].setup {capabilities = capabilities}
