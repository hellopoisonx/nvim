return {
    {
        "akinsho/bufferline.nvim",
        version = "*",
        dependencies = "nvim-tree/nvim-web-devicons",
        keys = {
            {
                "<C-l>",
                "<cmd>BufferLineCycleNext<cr>",
                desc = "move to next buffer"
            },
            {
                "<C-h>",
                "<cmd>BufferLineCyclePrev<cr>",
                desc = "move to previous buffer"
            },
            {
                "<C-x>",
                "<cmd>BufferLinePickClose<cr>",
                desc = "pick buffer to close"
            }
        },
        lazy = false,
        config = function()
            local bufferline = require('bufferline')
            bufferline.setup({
                options = {
                    mode = "buffers",
                    themable = true,
                    numbers = "none",
                    indicator = {
                        icon = '▎',
                        style = 'icon',
                    },
                    buffer_close_icon = '󰅖',
                    modified_icon = '●',
                    close_icon = '',
                    left_trunc_marker = '',
                    right_trunc_marker = '',
                    diagnostics = "nvim_lsp",
                    offsets = {
                        {
                            filetype = "NvimTree",
                            text = "File Explorer",
                            text_align = "left",
                            separator = true
                        }
                    }
                }

            })
        end
    }
}
