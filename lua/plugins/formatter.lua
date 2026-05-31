local function has(exe)
	return vim.fn.executable(exe) == 1
end

local function prettier()
	if not has("prettier") then
		return nil
	end
	local util = require("formatter.util")
	return {
		exe = "prettier",
		args = { "--stdin-filepath", util.escape_path(util.get_current_buffer_file_path()) },
		stdin = true,
		try_node_modules = true,
	}
end

return {
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		event = "VeryLazy",
		dependencies = { "mason-org/mason.nvim" },
		opts = {
			ensure_installed = {
				"stylua",
				"black",
				"ruff",
				"goimports",
				"gofumpt",
				"golangci-lint",
				"shfmt",
				"shellcheck",
				"prettier",
				"eslint_d",
				"markdownlint-cli2",
				"yamllint",
				"actionlint",
			},
			auto_update = false,
			run_on_start = true,
			start_delay = 3000,
		},
	},
	{
		"mhartington/formatter.nvim",
		cmd = { "Format", "FormatWrite", "FormatLock", "FormatWriteLock" },
		keys = {
			{
				"<leader>fm",
				function()
					local ok = pcall(vim.cmd, "Format")
					if not ok then
						vim.lsp.buf.format({ async = true })
					end
				end,
				mode = { "n", "v" },
				desc = "格式化当前文件",
			},
		},
		config = function()
			local util = require("formatter.util")

			require("formatter").setup({
				logging = true,
				log_level = vim.log.levels.WARN,
				filetype = {
					lua = {
						function()
							if not has("stylua") then
								return nil
							end
							return {
								exe = "stylua",
								args = {
									"--search-parent-directories",
									"--stdin-filepath",
									util.escape_path(util.get_current_buffer_file_path()),
									"-",
								},
								stdin = true,
							}
						end,
					},
					python = {
						function()
							if not has("black") then
								return nil
							end
							return { exe = "black", args = { "--quiet", "-" }, stdin = true }
						end,
					},
					-- go: 由 go.nvim 处理格式化 (gofumpt + goimports)
					sh = {
						function()
							if not has("shfmt") then
								return nil
							end
							return {
								exe = "shfmt",
								args = { "-filename", util.escape_path(util.get_current_buffer_file_path()) },
								stdin = true,
							}
						end,
					},
					javascript = { prettier },
					javascriptreact = { prettier },
					typescript = { prettier },
					typescriptreact = { prettier },
					json = { prettier },
					jsonc = { prettier },
					css = { prettier },
					scss = { prettier },
					html = { prettier },
					markdown = { prettier },
					yaml = { prettier },
					["*"] = {
						require("formatter.filetypes.any").remove_trailing_whitespace,
					},
				},
			})
		end,
	},
}
