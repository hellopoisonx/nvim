return {
	{
		"nvim-mini/mini.files",
		version = false,
		dependencies = { "nvim-tree/nvim-web-devicons" },
		keys = {
			{
				"<leader>fe",
				function()
					if not require("mini.files").close() then
						require("mini.files").open()
					end
				end,
				desc = "打开/关闭文件浏览器",
			},
		},
		init = function()
			vim.g.loaded_netrw = 1
			vim.g.loaded_netrwPlugin = 1
		end,
		config = function()
			require("mini.files").setup({
				windows = {
					preview = true,
					width_preview = 60,
				},
				filesystem = {
					git_status_hl = true,
				},
				options = {
					use_as_default_explorer = true,
				},
			})
		end,
	},
	{
		"nvim-mini/mini.jump",
		version = false,
		event = "VeryLazy",
		config = function()
			require("mini.jump").setup({
				mappings = {
					forward = "f",
					backward = "F",
					forward_till = "t",
					backward_till = "T",
					repeat_jump = ";",
				},
			})
		end,
	},
	{
		"nvim-mini/mini.jump2d",
		version = false,
		event = "VeryLazy",
		config = function()
			require("mini.jump2d").setup({
				-- 用 <CR> 覆盖 normal 模式默认的「跳到行首」行为以触发 jump2d
				mappings = {
					start_jumping = "<CR>",
				},
				silent = true,
			})
			-- 覆盖默认高亮，避免 catppuccin 主题下与背景色同色导致标签不可见
			-- Spot: 显著色块；Unique: 边框强调；Ahead: 较暗的预提示
			local set_hl = vim.api.nvim_set_hl
			local function refresh_jump2d_hl()
				set_hl(0, "MiniJump2dSpot", { fg = "#1e1e2e", bg = "#fab387", bold = true })
				set_hl(0, "MiniJump2dSpotUnique", { fg = "#1e1e2e", bg = "#94e2d5", bold = true })
				set_hl(0, "MiniJump2dSpotAhead", { fg = "#a6adc8", bg = "#313244", bold = true })
			end
			refresh_jump2d_hl()
			vim.api.nvim_create_autocmd("ColorScheme", {
				group = vim.api.nvim_create_augroup("MiniJump2dHighlight", { clear = true }),
				callback = refresh_jump2d_hl,
			})
		end,
	},
	{
		"numToStr/Comment.nvim",
		keys = { "gcc", "gc", "gbc", "gb" },
		opts = {},
	},
	{
		"nvzone/floaterm",
		dependencies = { "nvzone/volt" },
		cmd = "FloatermToggle",
		keys = {
			{ "<C-/>", "<cmd>FloatermToggle<CR>", mode = { "n", "t" }, desc = "切换浮动终端" },
			{ "<C-_>", "<cmd>FloatermToggle<CR>", mode = { "n", "t" }, desc = "切换浮动终端" },
		},
		opts = {
			border = true,
			size = { h = 75, w = 80 },
			terminals = {
				{ name = "Terminal" },
			},
		},
	},
	{
		"romgrk/barbar.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		event = "VeryLazy",
		keys = {
			{ "<A-h>", "<cmd>BufferPrevious<CR>", desc = "上一个 Buffer" },
			{ "<A-l>", "<cmd>BufferNext<CR>", desc = "下一个 Buffer" },
			{ "<leader>bd", "<cmd>BufferClose<CR>", desc = "关闭当前 Buffer" },
		},
		init = function()
			vim.g.barbar_auto_setup = false
		end,
		opts = {
			animation = false,
			icons = { separator = { left = "", right = "" } },
		},
	},
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		lazy = false,
		build = function()
			if vim.fn.executable("tree-sitter") == 1 then
				vim.cmd("TSUpdate")
			end
		end,
		config = function()
			local parsers = {
				"bash",
				"go",
				"gomod",
				"gosum",
				"json",
				"lua",
				"luadoc",
				"markdown",
				"markdown_inline",
				"python",
				"query",
				"vim",
				"vimdoc",
				"yaml",
			}

			require("nvim-treesitter").setup({
				install_dir = vim.fn.stdpath("data") .. "/site",
			})

			if vim.fn.executable("tree-sitter") == 1 then
				require("nvim-treesitter").install(parsers)
			else
				vim.schedule(function()
					vim.notify(
						"nvim-treesitter: 未检测到 tree-sitter CLI，请先执行 `sudo pacman -S tree-sitter`",
						vim.log.levels.WARN
					)
				end)
			end

			local group = vim.api.nvim_create_augroup("UserTreesitterSetup", { clear = true })

			vim.api.nvim_create_autocmd("FileType", {
				group = group,
				pattern = {
					"bash",
					"go",
					"gomod",
					"gosum",
					"json",
					"lua",
					"luadoc",
					"markdown",
					"python",
					"query",
					"vim",
					"vimdoc",
					"yaml",
				},
				callback = function(args)
					pcall(vim.treesitter.start, args.buf)
				end,
			})

			vim.api.nvim_create_autocmd("FileType", {
				group = group,
				pattern = { "go", "gomod", "lua", "python", "yaml", "json", "vim" },
				callback = function(args)
					vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				end,
			})
		end,
	},
	{
		"MeanderingProgrammer/render-markdown.nvim",
		ft = { "markdown" },
		dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
		opts = {
			completions = { lsp = { enabled = true } },
			heading = { border = true },
			code = { border = "thin" },
		},
	},
	{
		"selimacerbas/markdown-preview.nvim",
		dependencies = { "selimacerbas/live-server.nvim" },
		cmd = { "MarkdownPreview", "MarkdownPreviewStop", "MarkdownPreviewRefresh" },
		keys = {
			{ "<leader>mps", "<cmd>MarkdownPreview<CR>", desc = "Markdown: 开始预览" },
			{ "<leader>mpS", "<cmd>MarkdownPreviewStop<CR>", desc = "Markdown: 停止预览" },
			{ "<leader>mpr", "<cmd>MarkdownPreviewRefresh<CR>", desc = "Markdown: 刷新预览" },
		},
		config = function()
			require("markdown_preview").setup({
				instance_mode = "takeover",
				port = 0,
				open_browser = true,
				default_theme = "dark",
				debounce_ms = 300,
			})
		end,
	},
}
