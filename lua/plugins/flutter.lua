return {
    {
        'akinsho/flutter-tools.nvim',
        lazy = false,
        dependencies = {
            'nvim-lua/plenary.nvim',
            'stevearc/dressing.nvim', -- optional for vim.ui.select
        },
        config = function()
            local lsp_attach = require("commons.lsp")
            require('flutter-tools').setup {
                lsp = {
                    color = {
                        enabled = true,
                        background = true,
                        virtual_text = true,
                        virtual_text_str = "■",
                    },
                    on_attach = lsp_attach.lsp_attach
                }
            }
        end
    }
}
