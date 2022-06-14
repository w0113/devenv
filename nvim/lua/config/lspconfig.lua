-- Disable virtual text for diagnostics.
vim.diagnostic.config {
  virtual_text = false
}

-- Show diagnostics in a floating window instead.
vim.api.nvim_create_autocmd("CursorHold", {
  buffer = bufnr,
  callback = function()
    local opts = {
      focusable = false,
      close_events = {"BufLeave", "CursorMoved", "InsertEnter", "FocusLost"},
      border = 'rounded',
      source = 'always',
      prefix = ' ',
      scope = 'cursor',
    }
    vim.diagnostic.open_float(nil, opts)
  end
})

-- Mappings when a LSP is attached.
local config = {
  on_attach = function(client, bufnr)
    local map = vim.api.nvim_buf_set_keymap
    local default_options = {noremap = true, silent = true}

    map(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', default_options)
    map(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', default_options)
    map(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', default_options)
    map(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', default_options)
    --map(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', default_options)
    --map(bufnr, 'n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', default_options)
    --map(bufnr, 'n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', default_options)
    --map(bufnr, 'n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', default_options)
    map(bufnr, 'n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', default_options)
    map(bufnr, 'n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', default_options)
    map(bufnr, 'n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', default_options)
    map(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', default_options)
    map(bufnr, 'n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', default_options)
  end
}

local status_ok, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
if status_ok then
  local capabilities = cmp_nvim_lsp.update_capabilities(vim.lsp.protocol.make_client_capabilities())
  --capabilities.textDocument.completion.completionItem.snippetSupport = true
  config.capabilities = capabilities
end

---- List of LSP servers
local servers = {'cssls', 'html', 'solargraph', 'tsserver'}
-- Initialize LSP servers with our configuration
for _, lsp in pairs(servers) do
  require('lspconfig')[lsp].setup(config)
end
