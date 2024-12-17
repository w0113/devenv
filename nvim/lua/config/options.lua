-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.o.textwidth = 120
vim.o.colorcolumn = "+1"

vim.o.sidescroll = 1
vim.o.sidescrolloff = 1

vim.o.list = false
vim.o.listchars = "eol:¶,tab:‣ ,space:·,trail:·,extends:»,precedes:«,nbsp:␣"

-- Disable all animations
vim.g.snacks_animate = false
