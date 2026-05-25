return {
	{
		"stevearc/overseer.nvim",
		cmd = {
			"OverseerOpen",
			"OverseerClose",
			"OverseerToggle",
			"OverseerSaveBundle",
			"OverseerLoadBundle",
			"OverseerDeleteBundle",
			"OverseerRunCmd",
			"OverseerRun",
			"OverseerInfo",
			"OverseerBuild",
			"OverseerQuickAction",
			"OverseerTaskAction",
			"OverseerClearCache",
		},
		keys = {
			{ "<leader>or", "<cmd>OverseerRun<CR>", desc = "运行任务" },
			{ "<leader>oc", "<cmd>OverseerRunCmd<CR>", desc = "运行命令任务" },
			{ "<leader>ot", "<cmd>OverseerToggle<CR>", desc = "切换任务列表" },
			{ "<leader>oa", "<cmd>OverseerTaskAction<CR>", desc = "任务操作" },
			{ "<leader>oq", "<cmd>OverseerQuickAction<CR>", desc = "任务快捷操作" },
			{ "<leader>oi", "<cmd>OverseerInfo<CR>", desc = "Overseer 信息" },
		},
		opts = {
			dap = false,
			templates = { "builtin" },
			task_list = {
				keymaps = {
					["<C-j>"] = false,
					["<C-k>"] = false,
				},
			},
			form = {
				win_opts = {
					winblend = 0,
				},
			},
			task_win = {
				win_opts = {
					winblend = 0,
				},
			},
		},
	},
}
