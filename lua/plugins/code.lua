local vim = vim
return {
	-- {
	-- 	"hrsh7th/cmp-nvim-lua",
	-- 	event = "InsertEnter",
	-- 	enabled = false,
	-- },
	{
		"folke/neodev.nvim",
		event = "InsertEnter",
		enbaled = true,
	},
	{ -- luasnip
		"L3MON4D3/LuaSnip",
		version = "1.2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
		build = "make install_jsregexp",
	},
	{ -- lsp设置
		"hrsh7th/cmp-nvim-lsp",
		-- event = "InsertEnter",
		-- enabled = true,
		config = function()
			require("neodev").setup({})
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			local function on_attach(client, bufnr)
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
				vim.keymap.set("n", "<F3>", vim.lsp.buf.rename, bufopts) -- 重命名
			end
			-- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
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
			require("lspconfig")["bashls"].setup({
				capabilities = capabilities,
				on_attach = on_attach,
			})
			require("lspconfig")["pylsp"].setup({
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
					["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
					["<C-u>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
				}),
				sources = cmp.config.sources({
					{ name = "orgmode" },
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
	{
		"ray-x/lsp_signature.nvim",
		-- event = "InsertEnter",
		enabled = false,
		config = function()
			require("lsp_signature").setup()
		end,
	},
	{ -- comment
		"numToStr/Comment.nvim",
		event = "InsertEnter",
		enabled = true,
		config = function()
			require("Comment").setup()
		end,
	},
	{ -- autopairs
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		enabled = true,
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
