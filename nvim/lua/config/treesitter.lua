require('nvim-treesitter.configs').setup {
  -- A list of parser names, or "all"
  ensure_installed = {
    "bash",
    "comment",
    "css",
    "dockerfile",
    "html",
    "http",
    "javascript",
    "jsdoc",
    "json",
    "lua",
    "python",
    "regex",
    "ruby",
    "scss",
    "tsx",
    "typescript",
    "vim",
    "yaml"
  },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,
  -- List of parsers to ignore installing (for "all")
  ignore_install = {},

  highlight = {
    enable = true,
  },

  indent = {
    enable = false
  },
}
