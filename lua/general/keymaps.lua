-- keymaps
vim.g.mapleader = " "
vim.g.maplocalleader = " "
local map = vim.api.nvim_set_keymap
local opt = { noremap = true, silent = true }
-- 取消 s 默认功能
-- map("n", "s", "", opt)
-- use system clipboard
map("n", "Y", '"+y', opt)
map("n", "P", '"+p', opt)
map("v", "Y", '"+y', opt)
-- cancel highlight
map("n", "c/", "<cmd>noh<cr>", opt)
-- esc
map("i", "jj", "<ESC>", opt)
map("c", "<C-[>", "<ESC>", opt)
map("v", "<C-[>", "<ESC>", opt)
map("t", "jj", "<C-\\><C-n>", opt)
-- windows 分屏快捷键
map("n", "sv", ":vsp<CR>", opt)
map("n", "sh", ":sp<CR>", opt)
-- 关闭当前
map("n", "sc", "<C-w>c", opt)
-- 关闭其他
map("n", "so", "<C-w>o", opt)
-- Alt + hjkl  窗口之间跳转
map("n", "<A-h>", "<C-w>h", opt)
map("n", "<A-j>", "<C-w>j", opt)
map("n", "<A-k>", "<C-w>k", opt)
map("n", "<A-l>", "<C-w>l", opt)
-- 窗口比例控制
map("n", "<C-Left>", ":vertical resize -2<CR>", opt)
map("n", "<C-Right>", ":vertical resize +2<CR>", opt)
map("n", "<C-Down>", ":resize +2<CR>", opt)
map("n", "<C-Up>", ":resize -2<CR>", opt)
map("n", "<C-=>", "<C-w>=", opt)
-- visual模式下缩进代码
map("v", "<", "<gv", opt)
map("v", ">", ">gv", opt)
-- 上下移动选中文本
map("v", "J", ":move '>+1<CR>gv-gv", opt)
map("v", "K", ":move '<-2<CR>gv-gv", opt)
-- visual模式粘贴不复制
map("v", "p", '"_dP', opt)
-- lazy
map("n", "<leader>l", "<cmd>Lazy<cr>", opt)
