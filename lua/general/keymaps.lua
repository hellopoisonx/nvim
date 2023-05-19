-- keymaps
vim.g.mapleader = ","
vim.g.maplocalleader = ","
local map = vim.api.nvim_set_keymap
local opt = {noremap = true, silent = true}
-- 取消 s 默认功能
-- map("n", "s", "", opt)
-- use system clipboard
map("n", "Y", '"+y', opt)
map("n", "P", '"+p', opt)
map("v", "Y", '"+y', opt)
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
-- Lazy
map("n", "<leader>l", "<cmd>Lazy<cr>", opt)
-- plugin
-- tab
-- map("n", "<C-n>", ":tabe<CR>", opt)
-- map("n", "tl", ":tabprevious<CR>", opt)
-- map("n", "tr", ":tabnext<CR>", opt)
-- map("n", "tc", ":tabclose<CR>", opt)
-- map("n", "<C-h>", ":BufferLineCyclePrev<CR>", opt)
-- map("n", "<C-l>", ":BufferLineCycleNext<CR>", opt)
-- map("n", "<C-c>", ":BufferLinePickClose<CR>", opt)
-- Terminal相关
-- map("n", "<leader>t", "<cmd>ToggleTerm size=5 direction=float<CR>", opt)
-- map("n", "<leader>vt", ":vsp | terminal<CR>", opt)
-- map("t", "<Esc>", "<C-\\><C-n>", opt)
-- map("t", "<A-h>", [[ <C-\><C-N><C-w>h ]], opt)
-- map("t", "<A-j>", [[ <C-\><C-N><C-w>j ]], opt)
-- map("t", "<A-k>", [[ <C-\><C-N><C-w>k ]], opt)
-- map("t", "<A-l>", [[ <C-\><C-N><C-w>l ]], opt)
-- insert 模式下，跳到行首行尾
-- map("i", "<C-h>", "<ESC>I", opt)
-- map("i", "<C-l>", "<ESC>A", opt)
-- fzf-lua insert mode path completion
-- map("i", "<leader>x", '<cmd>lua require("fzf-lua").complete_path()<cr>', opt)
-- telescope
-- map("n", "<leader>ff",
--   "<cmd>Telescope find_files find_command=rg,--ignore,--files<CR>", opt)
-- map("n", "<leader>fg", "<cmd>Telescope live_grep find_command=rg<CR>", opt)
-- map("n", "<leader>fb", "<cmd>Telescope buffers<CR>", opt)
-- map("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", opt)
-- nvim-tree-lua
-- map("n", "<leader>nt", "<cmd>NvimTreeToggle<CR>", opt)
-- -- bufferline
-- map("n", "<C-L>", ":bnext<CR>", opt)
-- map("n", "<C-H>", ":bprevious<CR>", opt)
-- map("n", "<C-n>", ":close<CR>", opt)
-- translate
-- map('n', 'mi', '<Cmd>TranslateInput<CR>', opt)
-- map('n', 'mm', '<Cmd>Translate<CR>', opt)
-- map('n', 'mk', '<Cmd>TransPlay<CR>', opt) -- 自动发音选中或者光标下的单词
-- -- cmp
-- map("i", "<leader>f", "<cmd>lua require('cmp').mapping.scroll_docs(4)<CR>", opt)
-- map("i", "<leader>b", "<cmd>lua require('cmp').mapping.scroll_docs(-4)<CR>", opt)
-- toggleterm
-- map("n", "<C-s>", "<Cmd>MarkdownPreview<CR>", opt)
