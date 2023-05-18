return {
    {
        'nvim-lualine/lualine.nvim',
        dependencies = {
            'nvim-tree/nvim-web-devicons', 'arkav/lualine-lsp-progress'
        },
        config = function()
            require("lualine").setup({
                options = {theme = "tokyonight"},
                sections = {
                    lualine_a = {'mode'},
                    lualine_b = {'branch', 'diff', 'diagnostics', 'buffers'},
                    lualine_c = {'lsp_progress'},
                    lualine_x = {
                        'encoding', 'filesize', 'fileformat', 'filetype'
                    },
                    lualine_y = {'progress'},
                    lualine_z = {'location'}
                },
                inactive_sections = {
                    lualine_a = {},
                    lualine_b = {},
                    lualine_c = {'filename'},
                    lualine_x = {'location'},
                    lualine_y = {},
                    lualine_z = {}
                }
            })
        end
    }
}
