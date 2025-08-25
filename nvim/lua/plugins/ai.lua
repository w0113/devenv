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
      { "<leader>at", "<cmd>CopilotChatToggle<cr>", desc = "Toggle (CopilotChat)", mode = "n" },
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
}
