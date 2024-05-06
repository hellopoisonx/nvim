return {
  "akinsho/flutter-tools.nvim",
  lazy = false,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "stevearc/dressing.nvim",
  },
  config = function()
    require("flutter-tools").setup({
      lsp = {
        on_attach = require("lazyvim.util").lsp.on_attach,
      },
    })
  end,
}
