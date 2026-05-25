return {
	{
		"nvim-tree/nvim-tree.lua",
		version = "*",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		keys = {
			{ "<leader>fe", "<cmd>NvimTreeToggle<CR>", desc = "打开/关闭文件树" },
		},
		init = function()
			vim.g.loaded_netrw = 1
			vim.g.loaded_netrwPlugin = 1
		end,
		opts = {
			sort = { sorter = "case_sensitive" },
			view = {
				width = 32,
				side = "left",
			},
			renderer = {
				group_empty = true,
				highlight_git = true,
				icons = {
					show = {
						file = true,
						folder = true,
						folder_arrow = true,
						git = true,
					},
				},
			},
			filters = {
				dotfiles = false,
				git_ignored = false,
			},
			git = {
				enable = true,
				ignore = false,
			},
			actions = {
				open_file = {
					quit_on_open = false,
					resize_window = true,
				},
			},
		},
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
}
