return {
  {
    "phaazon/hop.nvim",
    opts = { keys = "asdklöqwertzuiopyxcvbnm,.fghj" },
    keys = {
      { "s", "<cmd>HopWordMW<cr>", mode = { "n", "o", "x" }, desc = "Hop to Word" },
      { "S", "<cmd>HopChar1MW<cr>", mode = { "n", "o", "x" }, desc = "Hop to Character" },
    },
  },
}
