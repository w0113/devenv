-- Collection of AI plugins and settings. This file must only be loaded when the environment variable "NVIM_USE_AI" is
-- set. Don"t forget to enable ai.copilot and ai.copilot-chat in :LazyExtras when using this configuration.
if not os.getenv("NVIM_USE_AI") then
  return {}
end

return {
  -- Tweak options of LazyVim default plugins
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    keys = {
      {
        "<leader>ae",
        "<cmd>CopilotChatExplain<cr>",
        desc = "Explain (CopilotChat)",
        mode = { "n", "v" },
      },
    },
    opts = {
      mappings = {
        reset = {
          normal = "gn",
          insert = "",
        },
      },
    },
  },

  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    version = false, -- Never set this value to "*"! Never!
    opts = {
      provider = "copilot",
      selector = {
        provider = "telescope",
        provider_opts = {},
      },
    },
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    build = "make",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
      "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
      "zbirenbaum/copilot.lua", -- for providers="copilot"
      {
        -- support for image pasting
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          -- recommended settings
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            -- required for Windows users
            use_absolute_path = true,
          },
        },
      },
      {
        -- Make sure to set this up properly if you have lazy=true
        "MeanderingProgrammer/render-markdown.nvim",
        opts = {
          file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
      },
    },
  },

  -- Avante was build with nvim-cmp in mind, but because LazyVim uses blink.cmp, we need to add blink-cmp-avante.
  {
    "saghen/blink.cmp",
    dependencies = {
      "Kaiser-Yang/blink-cmp-avante",
    },
    opts = {
      sources = {
        -- Add "avante" to the list
        default = { "avante", "lsp", "path", "luasnip", "buffer" },
        providers = {
          avante = {
            module = "blink-cmp-avante",
            name = "Avante",
          },
        },
      },
    },
  },
}
