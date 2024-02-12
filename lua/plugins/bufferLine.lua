-- using lazy.nvim
return {'akinsho/bufferline.nvim', version = "*",lazy=false, dependencies = 'nvim-tree/nvim-web-devicons',
config = true,
keys = {
			{
				"<C-l>",
				"<cmd>BufferLineCycleNext<cr>",
				desc = "move to next buffer",
			},
			{
				"<C-h>",
				"<cmd>BufferLineCyclePrev<cr>",
				desc = "move to previous buffer",
			},
			{
				"<C-x>",
				"<cmd>BufferLinePickClose<cr>",
				desc = "pick buffer to close",
			},
		},

}
