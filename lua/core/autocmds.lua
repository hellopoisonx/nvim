local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local autosave_delay = 1200
local autosave_group = augroup("AutoSaveAfterDelay", { clear = true })
local autosave_timers = {}

local function stop_timer(bufnr)
	local timer = autosave_timers[bufnr]
	if not timer then
		return
	end

	timer:stop()
	timer:close()
	autosave_timers[bufnr] = nil
end

local function should_autosave(bufnr)
	if not vim.api.nvim_buf_is_valid(bufnr) then
		return false
	end

	if not vim.bo[bufnr].modifiable or vim.bo[bufnr].readonly then
		return false
	end

	if vim.bo[bufnr].buftype ~= "" then
		return false
	end

	if vim.api.nvim_buf_get_name(bufnr) == "" then
		return false
	end

	if not vim.bo[bufnr].modified then
		return false
	end

	return true
end

local function save_buffer(bufnr)
	stop_timer(bufnr)

	if not should_autosave(bufnr) then
		return
	end

	vim.api.nvim_buf_call(bufnr, function()
		vim.cmd("silent update")
	end)
end

local function schedule_autosave(bufnr)
	if not should_autosave(bufnr) then
		stop_timer(bufnr)
		return
	end

	stop_timer(bufnr)

	local timer = vim.uv.new_timer()
	autosave_timers[bufnr] = timer
	timer:start(
		autosave_delay,
		0,
		vim.schedule_wrap(function()
			save_buffer(bufnr)
		end)
	)
end

local general = augroup("GeneralSettings", { clear = true })

autocmd("TextYankPost", {
	group = general,
	callback = function()
		vim.highlight.on_yank({ timeout = 150 })
	end,
})

autocmd({ "BufRead", "BufNewFile" }, {
	group = general,
	pattern = { "*.md", "*.txt", "*.tex" },
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.linebreak = true
	end,
})

autocmd("FileType", {
	group = general,
	pattern = { "help", "man", "qf", "lspinfo", "checkhealth" },
	callback = function(event)
		vim.keymap.set("n", "q", "<cmd>close<CR>", { buffer = event.buf, silent = true })
	end,
})

autocmd("LspAttach", {
	group = augroup("LspKeymaps", { clear = true }),
	callback = function(event)
		local map = function(mode, lhs, rhs, desc)
			vim.keymap.set(mode, lhs, rhs, { buffer = event.buf, silent = true, desc = desc })
		end

		local function lspui_or_builtin(command, fallback)
			return function()
				local ok = pcall(vim.cmd, "LspUI " .. command)
				if not ok then
					fallback()
				end
			end
		end

		map("n", "K", lspui_or_builtin("hover", vim.lsp.buf.hover), "悬浮文档")
		map("n", "gd", lspui_or_builtin("definition", vim.lsp.buf.definition), "跳转定义")
		map("n", "gi", lspui_or_builtin("implementation", vim.lsp.buf.implementation), "跳转实现")
		map("n", "gI", lspui_or_builtin("type_definition", vim.lsp.buf.type_definition), "跳转类型/接口")
		map("n", "gr", lspui_or_builtin("reference", vim.lsp.buf.references), "查找引用")
		map("n", "<leader>cr", lspui_or_builtin("rename", vim.lsp.buf.rename), "符号重命名")
		map("n", "<leader>ca", lspui_or_builtin("code_action", vim.lsp.buf.code_action), "代码操作")
	end,
})

autocmd({ "TextChanged", "TextChangedI" }, {
	group = autosave_group,
	callback = function(event)
		schedule_autosave(event.buf)
	end,
})

autocmd({ "InsertLeave", "BufLeave", "FocusLost", "VimLeavePre" }, {
	group = autosave_group,
	callback = function(event)
		save_buffer(event.buf)
	end,
})

autocmd({ "BufWritePost", "BufDelete", "BufWipeout" }, {
	group = autosave_group,
	callback = function(event)
		stop_timer(event.buf)
	end,
})
