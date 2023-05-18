return {
	{
		"williamboman/mason.nvim",
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
			"neovim/nvim-lspconfig",
		},
		build = ":MasonUpdate", -- :MasonUpdate updates registry contents
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
		end,
	},
	{
		"hrsh7th/nvim-cmp",
		lazy = false,
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-vsnip",
			"hrsh7th/vim-vsnip",
		},
		config = function()
			local cmp = require("cmp")
			require("cmp").setup({
				snippet = {
					expand = function(args)
						vim.fn["vsnip#anonymous"](args.body)
					end,
				},
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
				mapping = cmp.mapping.preset.insert({
					["<C-j>"] = cmp.mapping.scroll_docs(-4),
					["<C-k>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "vsnip" }, 
				}, { { name = "buffer" }, { name = "path" }, { name = "cmdline" } }),
			})
			-- Set configuration for specific filetype.
			cmp.setup.filetype("gitcommit", {
				sources = cmp.config.sources({ { name = "buffer" } }),
			})

			-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
			cmp.setup.cmdline({ "/", "?" }, {
				mapping = cmp.mapping.preset.cmdline(),
				sources = { { name = "buffer" } },
			})

			-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
			cmp.setup.cmdline(":", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({ { name = "path" } }, { { name = "cmdline" } }),
			})
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			local on_attach = function(client, bufnr)
				local bufopts = { noremap = true, silent = true, buffer = bufnr }
				-- vim.keymap.set('n', '<C-o>', function()
				--     vim.lsp.document_symbols {symbol_width = 0.8}
				-- end, bufopts) -- 打开当前文件的符号
				vim.keymap.set("n", "gd", function()
					vim.lsp.buf.definition()
				end, bufopts) -- 跳转定义
				vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts) -- 模拟鼠标悬停
				vim.keymap.set("n", "gr", function()
					vim.lsp.buf.references({ fname_width = 0.4 })
				end, bufopts) -- 查找引用
				vim.keymap.set("n", "<F2>", vim.lsp.buf.rename, bufopts) -- 重命名
			end
			-- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
			require("lspconfig")["gopls"].setup({
				cmd = { "gopls" },
				on_attach = on_attach,
				capabilities = capabilities,
				settings = {
					gopls = {
						completeUnimported = true,
						usePlaceholders = true,
						experimentalPostfixCompletions = true,
						analyses = { unusedparams = true, shadow = true },
						staticcheck = true,
					},
				},
				init_options = { usePlaceholders = true },
			})
			require("lspconfig")["bashls"].setup({
				capabilities = capabilities,
				on_attach = on_attach,
			})
			require("lspconfig")["clangd"].setup({
				capabilities = capabilities,
				on_attach = on_attach,
			})
			require("lspconfig")["lua_ls"].setup({
				on_attach = on_attach,
				capabilities = capabilities,
			})
			require("lspconfig")["pylsp"].setup({
				on_attach = on_attach,
				capabilities = capabilities,
			})
		end,
	},
	{
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end,
		event = InsertEnter,
	},
	{
		"windwp/nvim-autopairs",
		config = function()
			local npairs = require("nvim-autopairs")
			local Rule = require("nvim-autopairs.rule")

			npairs.setup({
				check_ts = true,
				ts_config = {
					lua = { "string" }, -- it will not add a pair on that treesitter node
					javascript = { "template_string" },
					java = false, -- don't check treesitter on java
				},
			})

			local ts_conds = require("nvim-autopairs.ts-conds")

			-- press % => %% only while inside a comment or string
			npairs.add_rules({
				Rule("%", "%", "lua"):with_pair(ts_conds.is_ts_node({ "string", "comment" })),
				Rule("$", "$", "lua"):with_pair(ts_conds.is_not_ts_node({ "function" })),
			})
		end,
	},
}
