local servers = { "gopls", "pyright", "lua_ls", "ts_ls" }

return {
	{
		"mason-org/mason.nvim",
		cmd = "Mason",
		opts = {
			ui = { border = "rounded" },
		},
	},
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"mason-org/mason.nvim",
			"mason-org/mason-lspconfig.nvim",
			"hrsh7th/cmp-nvim-lsp",
		},
		config = function()
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			local ok_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
			if ok_cmp then
				capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
			end

			local server_configs = {
				gopls = {
					capabilities = capabilities,
					settings = {
						gopls = {
							gofumpt = true,
							staticcheck = true,
							analyses = {
								unusedparams = true,
								unusedwrite = true,
								useany = true,
							},
							hints = {
								assignVariableTypes = true,
								compositeLiteralFields = true,
								compositeLiteralTypes = true,
								constantValues = true,
								functionTypeParameters = true,
								parameterNames = true,
								rangeVariableTypes = true,
							},
						},
					},
				},
				pyright = {
					capabilities = capabilities,
					settings = {
						python = {
							analysis = {
								autoSearchPaths = true,
								diagnosticMode = "workspace",
								useLibraryCodeForTypes = true,
								typeCheckingMode = "basic",
							},
						},
					},
				},
				ts_ls = {
					capabilities = capabilities,
					settings = {
						typescript = {
							inlayHints = {
								includeInlayParameterNameHints = "all",
								includeInlayParameterNameHintsWhenArgumentMatchesName = false,
								includeInlayFunctionParameterTypeHints = true,
								includeInlayVariableTypeHints = true,
								includeInlayVariableTypeHintsWhenTypeMatchesName = false,
								includeInlayPropertyDeclarationTypeHints = true,
								includeInlayFunctionLikeReturnTypeHints = true,
								includeInlayEnumMemberValueHints = true,
							},
						},
						javascript = {
							inlayHints = {
								includeInlayParameterNameHints = "all",
								includeInlayParameterNameHintsWhenArgumentMatchesName = false,
								includeInlayFunctionParameterTypeHints = true,
								includeInlayVariableTypeHints = true,
								includeInlayVariableTypeHintsWhenTypeMatchesName = false,
								includeInlayPropertyDeclarationTypeHints = true,
								includeInlayFunctionLikeReturnTypeHints = true,
								includeInlayEnumMemberValueHints = true,
							},
						},
					},
				},
				lua_ls = {
					capabilities = capabilities,
					settings = {
						Lua = {
							runtime = { version = "LuaJIT" },
							diagnostics = { globals = { "vim" } },
							workspace = {
								checkThirdParty = false,
								library = {
									vim.env.VIMRUNTIME,
									"${3rd}/luv/library",
								},
							},
							telemetry = { enable = false },
						},
					},
				},
			}

			for _, server in ipairs(servers) do
				vim.lsp.config(server, server_configs[server] or { capabilities = capabilities })
			end

			require("mason-lspconfig").setup({
				ensure_installed = servers,
				automatic_enable = false,
			})

			vim.lsp.enable(servers)
		end,
	},
	{
		"jinzhongjia/LspUI.nvim",
		branch = "main",
		event = "LspAttach",
		dependencies = { "nvim-treesitter/nvim-treesitter", "MeanderingProgrammer/render-markdown.nvim" },
		config = function()
			require("LspUI").setup({
				rename = { enable = true, command_enable = true, border = "rounded" },
				code_action = { enable = true, command_enable = true, border = "rounded" },
				hover = { enable = true, command_enable = true, border = "rounded" },
				diagnostic = { enable = true, command_enable = true, border = "rounded", show_source = true },
				definition = { enable = true, command_enable = true },
				implementation = { enable = true, command_enable = true },
				type_definition = { enable = true, command_enable = true },
				declaration = { enable = true, command_enable = true },
				reference = { enable = true, command_enable = true },
				lightbulb = { enable = true, icon = "💡" },
				inlay_hint = { enable = true, command_enable = true },
			})
		end,
	},
}
