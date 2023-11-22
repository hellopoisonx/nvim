local vim = vim
return {
	-- {
	-- 	"hrsh7th/cmp-nvim-lua",
	-- 	event = "InsertEnter",
	-- 	enabled = false,
	-- },
	{
		"folke/neodev.nvim",
		event = "VeryLazy",
		enbaled = true,
	},
	{ -- luasnip
		"L3MON4D3/LuaSnip",
		version = "1.2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
		build = "make install_jsregexp",
	},
	{ -- lsp设置
		"hrsh7th/cmp-nvim-lsp",
		enabled = true,
		config = function()
			require("neodev").setup({})
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			local keymap = vim.keymap.set
			local function on_attach(client, bufnr)
				keymap("n", "gd", "<cmd>Lspsaga goto_definition<CR>") -- 跳转定义
				keymap("n", "K", "<cmd>Lspsaga hover_doc<CR>") -- 模拟鼠标悬停
				keymap("n", "KK", "<cmd>Lspsaga hover_doc ++keep<CR>") -- 模拟鼠标悬停
				keymap("n", "gr", "<cmd>Lspsaga rename<CR>") -- 查找引用
				keymap({ "n", "v" }, "<leader>a", "<cmd>Lspsaga code_action<CR>")
				keymap("n", "<cmd>Lspsaga goto_type_definition<CR>", "gt")
				keymap("n", "<leader>o", "<cmd>Lspsaga outline<CR>")
			end
			require("lspconfig")["clangd"].setup({
				capabilities = capabilities,
				on_attach = on_attach,
			})
			require("lspconfig")["lua_ls"].setup({
				capabilities = capabilities,
				on_attach = on_attach,
				settings = {
					Lua = {
						completion = {
							callSnippet = "Replace",
						},
					},
				},
			})
			require("lspconfig")["pyright"].setup({
				capabilities = capabilities,
				on_attach = on_attach,
			})
			-- GoLang
			require("lspconfig")["gopls"].setup({
				cmd = { "gopls" },
				on_attach = on_attach,
				capabilities = capabilities,
				settings = {
					gopls = {
						completeUnimported = true,
						experimentalPostfixCompletions = true,
						analyses = {
							unusedparams = true,
							shadow = true,
						},
						staticcheck = true,
					},
				},
				init_options = {
					usePlaceholders = true,
				},
			})
			-- html
			require("lspconfig")["jsonls"].setup({
				capabilities = capabilities,
				on_attach = on_attach,
			})
		end,
	},
	{ --cmp 配置
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		enabled = true,
		dependencies = {
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"saadparwaiz1/cmp_luasnip",
			"rafamadriz/friendly-snippets",
			"onsails/lspkind.nvim",
			"lukas-reineke/cmp-rg",
		},
		config = function()
			local cmp = require("cmp")
			local lspkind = require("lspkind")
			local kind_icons = {
				Text = "",
				Method = "󰆧",
				Function = "󰊕",
				Constructor = "",
				Field = "󰇽",
				Variable = "󰂡",
				Class = "󰠱",
				Interface = "",
				Module = "",
				Property = "󰜢",
				Unit = "",
				Value = "󰎠",
				Enum = "",
				Keyword = "󰌋",
				Snippet = "",
				Color = "󰏘",
				File = "󰈙",
				Reference = "",
				Folder = "󰉋",
				EnumMember = "",
				Constant = "󰏿",
				Struct = "",
				Event = "",
				Operator = "󰆕",
				TypeParameter = "󰅲",
			}
			cmp.setup({
				snippet = {
					-- REQUIRED - you must specify a snippet engine
					expand = function(args)
						-- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
						require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
						-- require('snippy').expand_snippet(args.body) -- For `snippy` users.
						-- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
					end,
				},
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
					-- experimental = {
					--     ghost_text = false,
					-- }
				},
				mapping = cmp.mapping.preset.insert({
					["<C-k>"] = cmp.mapping.select_prev_item(),
					["<C-j>"] = cmp.mapping.select_next_item(),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
				}),
				sources = cmp.config.sources({
					{ name = "rg" },
					{ name = "nvim_lsp" }, -- {name = 'vsnip'} -- For vsnip users.
					{ name = "nvim_lua" },
					{ name = "path" }, -- For luasnip users.
					-- { name = 'ultisnips' }, -- For ultisnips users.
					{ name = "luasnip" }, -- For snippy users.
					{ name = "buffer" },
				}),
				formatting = {
					format = lspkind.cmp_format({
						mode = "symbol_text",
						maxwidth = 50,
						ellipsis_char = "...",
						format = function(entry, vim_item)
							vim_item.kind = string.format("%s %s", kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
							vim_item.menu = ({
								orgmode = "[ORG]",
								rg = "[rg]",
								nvim_lsp = "[lsp]",
								nvim_lua = "[nvim_lua]",
								luasnip = "[luasnip]",
								buffer = "[buffer]",
								path = "[path]",
								cmdline = "[cmd]",
							})[entry.source.name]
							return vim_item
						end,
					}),
				},
			})

			-- Set configuration for specific filetype.
			cmp.setup.filetype("gitcommit", {
				sources = cmp.config.sources({
					{ name = "cmp_git" }, -- You can specify the `cmp_git` source if you were installed it.
				}, { { name = "buffer" } }),
			})

			-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
			cmp.setup.cmdline({ "/", "?" }, {
				mapping = cmp.mapping.preset.cmdline(),
				sources = { { name = "buffer" } },
			})

			-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
			cmp.setup.cmdline(":", {
				-- view = {
				-- 	entries = { name = "wildmenu", separator = "|" },
				-- },
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({ { name = "path" } }, { { name = "cmdline" } }),
			})
		end,
	},
	{ -- comment
		"numToStr/Comment.nvim",
		event = "VeryLazy",
		enabled = true,
		config = function()
			require("Comment").setup()
		end,
	},
}
