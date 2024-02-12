return {
    'nvimdev/lspsaga.nvim',
    lazy = true,
    event = "LspAttach",
    keys = {
        {
            "<leader>t",
            '<cmd>Lspsaga term_toggle<cr>',
            desc = "Open a floating terminal"
        }
    },
    config = function()
        require('lspsaga').setup({})
    end,
    dependencies = {
        'nvim-treesitter/nvim-treesitter', -- optional
        'nvim-tree/nvim-web-devicons'      -- optional
    }
}
