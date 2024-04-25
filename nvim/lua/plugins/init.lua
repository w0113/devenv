return {
  -- Disable some default plugins
  { "akinsho/bufferline.nvim", enabled = false },
  { "folke/flash.nvim", enabled = false },
  { "mini.indentscope", enabled = false },
  { "nvimdev/dashboard-nvim", enabled = false },

  -- Tweak options of LazyVim default plugins
  {
    "folke/tokyonight.nvim",
    opts = { dim_inactive = true },
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    opts = { scope = { enabled = true, show_start = false, show_end = false } },
  },

  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function(_, opts)
      -- Remove the last item of lualine_c, which is a shortened file path.
      table.remove(opts.sections.lualine_c)
      -- Instead we want to show the current relative filename
      table.insert(opts.sections.lualine_c, { "filename", path = 1 })
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "ruby",
      })
    end,
  },
}
