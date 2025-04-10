-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local unmap = vim.keymap.del

-- Restore behavior of H and L
unmap("n", "<S-h>")
unmap("n", "<S-l>")

-- Define mappings listed with which-key
Snacks.toggle.option("list", { name = "Display Whitespaces" }):map("<leader>uW")
