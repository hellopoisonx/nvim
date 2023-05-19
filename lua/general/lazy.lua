local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)
--
require("lazy").setup({
	spec = { { import = "plugins" } },
	default = { lazy = true, version = true },
	install = { missing = true, colorscheme = { "gruvbox" } },
	checker = { enabled = false }, -- automatically check for plugin updates
	performance = {
		rtp = {
			-- disable some rtp plugins
			disabled_plugins = {
				"gzip",
				"netrwPlugin",
				"tarPlugin",
				"tohtml",
				"tutor",
				"zipPlugin",
			},
        cache = {
                enabled = true,
                path = vim.fn.stdpath('cache') .. 'lazy/cache',
                disable_events = {"VimEnter", "BufReadPre"},
                ttl = 3600 * 24 * 5,
            },
        reset_packpath = true,
		},
	},
})
