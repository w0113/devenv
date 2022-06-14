local map = vim.keymap.set
local default_options = {noremap = true, silent = true}

require('trouble').setup()

map("n", "<leader><leader>x", "<cmd>TroubleToggle<cr>", default_options)
map("n", "<leader>xw", "<cmd>Trouble workspace_diagnostics<cr>", default_options)
map("n", "<leader>xd", "<cmd>Trouble document_diagnostics<cr>", default_options)
map("n", "<leader>xl", "<cmd>Trouble loclist<cr>", default_options)
map("n", "<leader>xq", "<cmd>Trouble quickfix<cr>", default_options)
map("n", "gR", "<cmd>Trouble lsp_references<cr>", default_options)
