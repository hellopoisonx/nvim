return {
	{
		"ray-x/go.nvim",
		enabled = false,
		dependencies = { -- optional packages
			"ray-x/guihua.lua",
			"neovim/nvim-lspconfig",
			"nvim-treesitter/nvim-treesitter",
		},
		keys = {
			{ "er", mode = { "n" }, "<cmd>GoIfErr<cr>", desc = "Add if and err" },
			{ "fs", mode = { "n" }, "<cmd>GoFillStruct<cr>", desc = "Auto fill struct" },
			{ "<leader>a", mode = { "n" }, "<cmd>GoCodeAction<cr>", desc = "Code Action" },
		},
		config = function()
			-- local keymap = vim.keymap.set
			-- local function on_attach()
			-- 	keymap("n", "gd", "<cmd>Lspsaga goto_definition<CR>") -- 跳转定义
			-- 	keymap("n", "K", "<cmd>Lspsaga hover_doc<CR>") -- 模拟鼠标悬停
			-- 	keymap("n", "KK", "<cmd>Lspsaga hover_doc ++keep<CR>") -- 模拟鼠标悬停
			-- 	keymap("n", "gr", "<cmd>Lspsaga rename<CR>") -- 查找引用
			-- 	keymap({ "n", "v" }, "<leader>a", "<cmd>Lspsaga code_action<CR>")
			-- 	keymap("n", "gt", "<cmd>Lspsaga goto_type_definition<CR>")
			-- 	keymap("n", "<leader>o", "<cmd>Lspsaga outline<CR>")
			-- end
			local capabilities =
				require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
			require("go").setup({
				-- other setups ....
				-- on_attach = on_attach,
				lsp_cfg = {
					capabilities = capabilities,
					-- other setups
				},
			})
		end,
		event = { "CmdlineEnter" },
		ft = { "go", "gomod" },
		build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
	},
}
