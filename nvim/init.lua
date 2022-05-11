-- Vim autocommands/autogroups
require("autocmd")
-- Vim mappings
require("mappings")
-- All non plugin related options
require("options")
-- Plugin management via Packer
require("plugins")

-- TODO: Does this work:
vim.g.do_filetype_lua = 1
vim.g.did_load_filetypes = 0

