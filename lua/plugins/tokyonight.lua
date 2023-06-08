return {
	{
		"folke/tokyonight.nvim",
        enabled = false,
		lazy = false,
		priority = 1000,
		opts = {style = "moon"},
        config = function()
            require("tokyonight").setup({
                style = "moon",
                transparent = true,
            })
        end,
	},
}
