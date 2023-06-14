return {
    {
        "nathom/filetype.nvim",
        lazy = true,
        event = "User FileOpened",
        config = function()
            require("filetype").setup({
                overrides = {
                    extensions = {
                        h = "cpp",
                        org = "org",
                        py = "py",
                        lua = "lua",
                        sh = "sh",
                    },
                }
            })
        end
    }
}
