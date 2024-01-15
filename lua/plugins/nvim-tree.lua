return {
	"nvim-tree/nvim-tree.lua",
	dependencies = {
		"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
	},
	keys = { { "<leader>nt", "<cmd>NvimTreeToggle<cr>", desc = "Open or close NvimTree" } },
	config = function()
		require("nvim-tree").setup()
	end,
}
