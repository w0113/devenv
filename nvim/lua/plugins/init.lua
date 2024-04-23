return {
  -- Disable some default plugins
  { "akinsho/bufferline.nvim", enabled = false },
  { "folke/flash.nvim", enabled = false },
  { "mini.indentscope", enabled = false },

  -- Tweak options of LazyVim default plugins
  {
    "lukas-reineke/indent-blankline.nvim",
    opts = { scope = { enabled = true, show_start = false, show_end = false } },
  },

  { "nvim-treesitter/nvim-treesitter", opts = { ensure_installed = { "ruby" } } },
}
