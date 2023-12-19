return {
	{
		"williamboman/mason.nvim",
        lazy = true,
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
			"neovim/nvim-lspconfig",
		},
		build = ":MasonUpdate", -- :MasonUpdate updates registry contents
		-- event = "InsertEnter",
		-- enabled = true,
        keys = {
            {"<leader>m", "<cmd>Mason<cr>", desc = "open mason"},
        },
		config = function()
			require("mason").setup({
				ui = {
					icons = {
						package_installed = "✓",
						package_pending = "➜",
						package_uninstalled = "✗",
					},
				},
			})
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "lua_ls",
                    "gopls",
                    "clangd",
                    "pyright",
                }
            })
		end,
	},
}
