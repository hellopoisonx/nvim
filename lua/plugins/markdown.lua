return {
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		ft = { "markdown" },
		build = function()
			vim.fn["mkdp#util#install"]()
		end,
	},
	{
		"TobinPalmer/pastify.nvim",
		cmd = { "Pastify" },
		config = function()
			require("pastify").setup({
				opts = {
					absolute_path = false,
					local_path = "/assets/imgs/",
					save = "local",
				},
				ft = { -- Custom snippets for different filetypes, will replace $IMG$ with the image url
					html = '<img src="$IMG$" alt="">',
					markdown = "![]($IMG$)",
					tex = [[\includegraphics[width=\linewidth]{$IMG$}]],
				},
			})
		end,
	},
}
