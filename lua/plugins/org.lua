return {
	{
		"nvim-orgmode/orgmode",
		enabled = false,
		event = "VimEnter",
		lazy = true,
		-- event = "VeryLazy",
		dependencies = {
			"akinsho/org-bullets.nvim",
			"lukas-reineke/headlines.nvim",
			"nvim-treesitter/nvim-treesitter",
			lazy = false,
		},
		config = function()
			require("orgmode").setup_ts_grammar()
			require("org-bullets").setup({

				concealcursor = false, -- If false then when the cursor is on a line underlying characters are visible
				symbols = {
					-- list symbol
					list = "•",
					-- headlines can be a list
					headlines = { "◉", "○", "✸", "✿" },
					-- or a function that receives the defaults and returns a list
					-- headlines = function(default_list)
					-- 	table.insert(default_list, "♥")
					-- 	return default_list
					-- end,
					checkboxes = {
						half = { "", "OrgTSCheckboxHalfChecked" },
						done = { "✓", "OrgDone" },
						todo = { "˟", "OrgTODO" },
					},
				},
			})
			require("orgmode").setup({
				org_agenda_files = { "~/agenda/org/*" },
				org_default_notes_file = "~/notebooks/english/words.org",
			})
		end,
	},
}
