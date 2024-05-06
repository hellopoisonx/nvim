return {
  "akinsho/toggleterm.nvim",
  lazy = true,
  event = "VeryLazy",
  version = "*",
  keys = {
    { "<leader>t", "<cmd>ToggleTerm<cr>", desc = "toggle float terminal" },
  },
  opts = {
    direction = "float",
    float_opts = {
      border = "curved",
      winblend = 3,
      title_pos = "left",
    },
  },
}
