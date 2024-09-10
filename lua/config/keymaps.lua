-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local opts = { noremap = true, silent = true }
local keymap = vim.keymap.set

-- ESC常用映射
keymap("i", "jk", "<ESC>", opts)
keymap("i", "kj", "<ESC>", opts)
keymap("i", "jj", "<ESC>", opts)
keymap("i", "kk", "<ESC>o", opts)
keymap("v", "q", "<ESC>", opts)

-- 快速跳转
keymap("n", "<C-h>", "^", opts)
keymap("n", "<C-l>", "$", opts)
keymap("v", "<C-h>", "^", opts)
keymap("v", "<C-l>", "$", opts)
keymap("n", "<C-j>", "5j", opts)
keymap("n", "<C-k>", "5k", opts)
keymap("v", "<C-j>", "5j", opts)
keymap("v", "<C-k>", "5k", opts)

-- Buffer操作
keymap("n", "<A-l>", ":bnext<CR>", opts)
keymap("n", "<A-h>", ":bprevious<CR>", opts)
keymap("n", "<S-q>", ":bdelete<CR>", opts)

-- 窗口大小调整
keymap("n", "<A-Right>", "<C-w>>", opts)
keymap("n", "<A-Left>", "<C-w><", opts)
keymap("n", "<A-Up>", "<C-w>+", opts)
keymap("n", "<A-Down>", "<C-w>-", opts)

-- 保持最后一次复制内容，粘贴后不进行替换
keymap("v", "p", '"_dP', opts)

-- 切换多行显示LSP错误信息
keymap("", "<A-i>", require("lsp_lines").toggle, { desc = "Toggle lsp_lines" })

-- 跳转到被固定行的代码位置
keymap("n", "<A-s>", function()
  require("treesitter-context").go_to_context(vim.v.count1)
end, opts)
