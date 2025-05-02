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
      { "<leader>aa", false },
      { "<leader>at", "<cmd>CopilotChatToggle<cr>",  desc = "Toggle (CopilotChat)",  mode = "n" },
      { "<leader>ae", "<cmd>CopilotChatExplain<cr>", desc = "Explain (CopilotChat)", mode = { "n", "v" } },
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
    "folke/which-key.nvim",
    opts = function(_, opts)
      opts.icons = {
        rules = {
          { pattern = "avante", icon = " ", color = "green" },
        },
      }
    end,
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
      mappings = {
        ask = "<leader>aaa",
        build = "<leader>aab",
        chat = "<leader>aac",
        files = {
          add_all_buffers = "<leader>aaB",
        },
        focus = "<leader>aaf",
        refresh = "<leader>aar",
        select_history = "<leader>aah",
        select_model = "<leader>aam",
        stop = "<leader>aaS",
        toggle = {
          debug = "<leader>aad",
          default = "<leader>aat",
          hint = "<leader>aaH",
          repomap = "<leader>aaR",
          suggestion = "<leader>aas",
        },
      },
    },
    keys = function(_, keys)
      ---@type avante.Config
      local opts =
          require("lazy.core.plugin").values(require("lazy.core.config").spec.plugins["avante.nvim"], "opts", false)

      local mappings = {
        {
          "<leader>aa",
          "",
          desc = "+agent",
          mode = { "n", "v" }
        },
        {
          opts.mappings.files.add_all_buffers,
          function() require("avante.api").add_buffer_files() end,
          desc = "Add all open buffers (avante)",
          mode = "n",
        },
        {
          opts.mappings.toggle.hint,
          "<Plug>(AvanteToggleHint)",
          desc = "Toggle hint (avante)",
          mode = "n",
        },
        {
          opts.mappings.toggle.repomap,
          function() require("avante.repo_map").show() end,
          desc = "Display repo map (avante)",
          mode = "n",
        },
        {
          opts.mappings.stop,
          function() require("avante.api").stop() end,
          desc = "Stop (avante)",
          mode = "n",
        },
        {
          opts.mappings.ask,
          "<Plug>(AvanteAsk)",
          desc = "Ask (avante)",
          mode = { "n", "v" }
        },
        {
          opts.mappings.build,
          "<Plug>(AvanteBuild)",
          desc = "Build (avante)",
          mode = "n",
        },
        {
          opts.mappings.chat,
          "<Plug>(AvanteChat)",
          desc = "Chat (avante)",
          mode = { "n", "v" }
        },
        {
          opts.mappings.toggle.debug,
          "<Plug>(AvanteToggleDebug)",
          desc = "Toggle debug (avante)",
          mode = "n",
        },
        {
          opts.mappings.focus,
          "<Plug>(AvanteFocus)",
          desc = "Focus (avante)",
          mode = "n",
        },
        {
          opts.mappings.select_history,
          function() require("avante.api").select_history() end,
          desc = "Select history (avante)",
          mode = "n",
        },
        {
          opts.mappings.select_model,
          "<Plug>(AvanteSelectModel)",
          desc = "Select model (avante)",
          mode = "n",
        },
        {
          opts.mappings.refresh,
          "<Plug>(AvanteRefresh)",
          desc = "Refresh (avante)",
          mode = "n",
        },
        {
          opts.mappings.toggle.suggestion,
          "<Plug>(AvanteToggleSuggestion)",
          desc = "Toggle suggestion (avante)",
          mode = "n",
        },
        {
          opts.mappings.toggle.default,
          "<Plug>(AvanteToggle)",
          desc = "Toggle (avante)",
          mode = "n",
        },
      }
      mappings = vim.tbl_filter(function(m) return m[1] and #m[1] > 0 end, mappings)
      return vim.list_extend(mappings, keys)
    end,
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    build = "make",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
      "nvim-tree/nvim-web-devicons",   -- or echasnovski/mini.icons
      "zbirenbaum/copilot.lua",        -- for providers="copilot"
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
        default = { "avante", "lsp", "path", "snippets", "buffer" },
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
