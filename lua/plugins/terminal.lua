return {
	{
		{
			"akinsho/toggleterm.nvim",
			version = "*",
			opts = { size = 15 },
			config = function()
				require("toggleterm").setup({})
			end,
			keys = {
				{ "<leader>t", "<cmd>ToggleTerm direction=float<cr>", desc = "open terminal" },
			},
		},
	},
}
