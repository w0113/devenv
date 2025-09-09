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

-- Mappings for file operations
map("n", "<leader>fp", "<cmd>let @\" = expand('%') | let @+ = @\"<cr>", { desc = "Yank Path of Current File" })
map("n", "<leader>fP", "<cmd>let @\" = expand('%:p') | let @+ = @\"<cr>", { desc = "Yank Full Path of Current File" })

-- Navigation mappings
map("n", "ö", "", { desc = "+prev" })
map("n", "öl", "<cmd>lprevious<cr>", { desc = "Previous Location List Item" })
map("n", "öq", "<cmd>cprevious<cr>", { desc = "Previous Trouble/Quickfix Item" })

map("n", "ä", "", { desc = "+next" })
map("n", "äl", "<cmd>lnext<cr>", { desc = "Next Location List Item" })
map("n", "äq", "<cmd>cnext<cr>", { desc = "Next Trouble/Quickfix Item" })

-- Define mappings listed with which-key
Snacks.toggle.option("list", { name = "Display Whitespaces" }):map("<leader>uW")
