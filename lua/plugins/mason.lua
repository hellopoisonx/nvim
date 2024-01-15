return {
	"williamboman/mason.nvim",
	lazy = true,
	event = "VimEnter",
	config = function()
		require("mason").setup({})
	end,
}
