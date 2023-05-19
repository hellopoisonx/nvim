return {
    {
        "nvim-treesitter/nvim-treesitter", 
        build = ":TSUpdate",
        dependencies = "p00f/nvim-ts-rainbow",
        config = function() 
            require("nvim-treesitter.configs").setup({
                ensure_installed = {"c", "cpp", "lua", "go", "python"},
                rainbow = {
                    enable = true,
                    extended_mode = true,
                    max_file_lines = nil,
                },
                indent = {
                    enable = true
                },
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false,
                }
            })
        end
    },
}
