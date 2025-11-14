-- 设置 leader 键
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- ESC常用映射
keymap("i", "jk", "<ESC>", opts)
keymap("i", "jj", "<ESC>", opts)
keymap("i", "kk", "<ESC>o", opts)

-- 快速跳转
keymap({"n", "v"}, "<C-h>", "^", opts)
keymap({"n", "v"}, "<C-l>", "$", opts)
keymap({"n", "v"}, "<C-j>", "5j", opts)
keymap({"n", "v"}, "<C-k>", "5k", opts)
-- 更好的 j/k 移动（处理折行）
keymap("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true })
keymap("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true })

-- 粘贴时不覆盖寄存器
keymap("v", "p", '"_dP', opts)

-- 保存文件
keymap("n", "<leader>w", ":w<CR>", { desc = "Save file" })
-- 退出
keymap("n", "<leader>q", ":q<CR>", { desc = "Quit" })
-- 强制退出
keymap("n", "<leader>Q", ":qa!<CR>", { desc = "Force quit all" })
-- 取消搜索高亮
keymap("n", "<Esc>", ":nohl<CR>", { desc = "Clear highlights", silent = true })

-- 移动选中文本
keymap("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move line down" })
keymap("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move line up" })
keymap("n", "<A-j>", ":m '>+1<CR>", opts)
keymap("n", "<A-k>", ":m '<-2<CR>", opts)

-- 将下一行内容快速移动到行尾
keymap("n", "J", "mzJ`z", opts)

-- 快速跳转到中间位置
keymap("n", "<C-d>", "<C-d>zz")
keymap("n", "<C-u>", "<C-u>zz")

-- 保持 Visual 选择状态
keymap("n", "n", "nzzzv")
keymap("n", "N", "Nzzzv")

-- 保持 Visual 选择状态
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Buffer 快捷键
keymap("n", "<A-h>", ":bprevious<CR>", { desc = "Previous buffer" })
keymap("n", "<A-l>", ":bnext<CR>", { desc = "Next buffer" })
keymap("n", "Q", ":bdelete<CR>", { desc = "Delete buffer" })

-- 分割窗口
keymap("n", "<leader>sv", ":vsplit<CR>", { desc = "Split vertically" })
keymap("n", "<leader>sh", ":split<CR>", { desc = "Split horizontally" })
keymap("n", "<leader>sx", ":close<CR>", { desc = "Close split" })

-- 文件内替换
keymap("n", "<leader>r", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Replace word cursor is on globally" })

