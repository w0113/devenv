return {
  {
    "tpope/vim-fugitive",
    cmd = "G",
    keys = {
      { "<leader>gd", "<cmd>Gvdiffsplit<cr>", desc = "Git Diff", mode = "n" },
      { "<leader>gr", "<cmd>0Gclog<cr>", desc = "File Revisions", mode = "n" },
    },
  },
}
