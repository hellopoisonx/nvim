return {
<<<<<<< HEAD
	"Pocco81/auto-save.nvim",
	config = function()
		require("auto-save").setup({
			enabled = true,
			execution_message = {
				message = function() -- message to print on save
					return ""
				end,
				dim = 0.18, -- dim the color of `message`
				cleaning_interval = 1250, -- (milliseconds) automatically clean MsgArea after displaying `message`. See :h MsgArea
			},
			trigger_events = { "InsertLeave", "TextChanged" },
			write_all_buffers = false,
			debounce_delay = 6000,
		})
	end,
=======
  "0x00-ketsu/autosave.nvim",
  enabled = false,
  lazy = true,
  event = { "InsertLeave", "TextChanged" },
  config = function()
    require("autosave").setup({
      enable = true,
      prompt_style = "stdout",
      prompt_message = function()
        -- return "Autosave: saved at " .. vim.fn.strftime("%H:%M:%S")
        return ""
      end,
      events = { "InsertLeave", "TextChanged" },
      conditions = {
        exists = true,
        modifiable = true,
        filename_is_not = {},
        filetype_is_not = {},
      },
      write_all_buffers = false,
      debounce_delay = 135,
    })
  end,
>>>>>>> 7f88408 (lazynvim)
}
