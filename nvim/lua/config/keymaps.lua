-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local map = vim.keymap.set
local unmap = vim.keymap.del

-- Restore behavior of H and L
unmap("n", "<S-h>")
unmap("n", "<S-l>")

-- Change LazyVim tab mappings
unmap("n", "<leader><tab>[")
unmap("n", "<leader><tab>]")
map("n", "<leader><tab>n", "<cmd>tabnext<cr>", { desc = "Next Tab" })
map("n", "<leader><tab>p", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })

-- Define mappings listed with which-key
Snacks.toggle.option("list", { name = "Display Whitespaces" }):map("<leader>uW")
