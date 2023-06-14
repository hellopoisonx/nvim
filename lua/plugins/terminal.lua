return {
    {
        {
            'akinsho/toggleterm.nvim',
            version = "*",
            opts = {size = 15},
            config = function() require("toggleterm").setup({}) end,
            keys = {
                {"<leader>t", "<cmd>ToggleTerm<cr>", desc = "open terminal"},
            }
        }
    }
}
