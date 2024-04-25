-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local map = vim.keymap.set
local unmap = vim.keymap.del

-- Rebind ö and ä to [] and {}
map("n", "ö", "[")
map("n", "ä", "]")
map("n", "Ö", "{")
map("n", "Ä", "}")

-- Restore behavior of H and L
unmap("n", "<S-h>")
unmap("n", "<S-l>")
