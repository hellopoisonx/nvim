return {
<<<<<<< HEAD
	{
		"akinsho/bufferline.nvim",
		version = "*",
		dependencies = "nvim-tree/nvim-web-devicons",
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
		lazy = false,
		config = function()
			local bufferline = require("bufferline")
			bufferline.setup({
				options = {
					mode = "buffers",
					themable = true,
					numbers = "none",
					indicator = {
						icon = "▎",
						style = "icon",
					},
					buffer_close_icon = "󰅖",
					modified_icon = "●",
					close_icon = "",
					left_trunc_marker = "",
					right_trunc_marker = "",
					diagnostics = "nvim_lsp",
					offsets = {
						{
							filetype = "NvimTree",
							text = "File Explorer",
							text_align = "left",
							separator = true,
						},
					},
				},
			})
		end,
	},
=======
  "akinsho/bufferline.nvim",
  opts = {
    options = {
    -- stylua: ignore
    close_command = function(n) require("mini.bufremove").delete(n, false) end,
    -- stylua: ignore
    right_mouse_command = function(n) require("mini.bufremove").delete(n, false) end,
      diagnostics = "nvim_lsp",
      always_show_bufferline = true,
      diagnostics_indicator = function(_, _, diag)
        local icons = require("lazyvim.config").icons.diagnostics
        local ret = (diag.error and icons.Error .. diag.error .. " " or "")
          .. (diag.warning and icons.Warn .. diag.warning or "")
        return vim.trim(ret)
      end,
      indicator = {
        -- icon = "▎", -- this should be omitted if indicator style is not 'icon'
        style = "underline",
      },
      offsets = {
        {
          filetype = "neo-tree",
          text = "Neo-tree",
          highlight = "Directory",
          text_align = "left",
        },
      },
    },
  },
>>>>>>> 7f88408 (lazynvim)
}
