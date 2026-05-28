local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- ESC常用映射
keymap("i", "jk", "<ESC>", opts)
keymap("i", "jj", "<ESC>ko", opts)
keymap("i", "kk", "<ESC>o", opts)

-- 快速跳转
keymap({ "n", "v" }, "<C-h>", "^", opts)
keymap({ "n", "v" }, "<C-l>", "$", opts)
keymap({ "n", "v" }, "<C-j>", "5j", opts)
keymap({ "n", "v" }, "<C-k>", "5k", opts)
-- 更好的 j/k 移动（处理折行）
keymap("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true })
keymap("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true })

-- 粘贴时不覆盖寄存器
keymap("v", "p", '"_dP', opts)

-- 保存文件
keymap("n", "<leader>w", "<cmd>w<CR>", { desc = "Save file" })
-- 退出
keymap("n", "<leader>qq", "<cmd>q<CR>", { desc = "Quit" })
-- 强制退出
keymap("n", "<leader>qa", "<cmd>qa!<CR>", { desc = "Force quit all" })
-- 取消搜索高亮
keymap("n", "<Esc>", "<cmd>nohl<CR>", { desc = "Clear highlights", silent = true })

-- 移动选中文本
keymap("v", "<A-j>", "<cmd>m '>+1<CR>gv=gv", { desc = "Move line down" })
keymap("v", "<A-k>", "<cmd>m '<-2<CR>gv=gv", { desc = "Move line up" })
keymap("n", "<A-j>", "<cmd>m .+1<CR>==", { desc = "Move line down" })
keymap("n", "<A-k>", "<cmd>m .-2<CR>==", { desc = "Move line up" })

-- 将下一行内容快速移动到行尾
keymap("n", "J", "mzJ`z", opts)

-- 快速跳转到中间位置
keymap("n", "<C-d>", "<C-d>zz")
keymap("n", "<C-u>", "<C-u>zz")

-- 保持 Visual 选择状态
keymap("n", "n", "nzzzv")
keymap("n", "N", "Nzzzv")

-- 快速缩进
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Buffer 快捷键
keymap("n", "<A-h>", "<cmd>bprevious<CR>", { desc = "Previous buffer" })
keymap("n", "<A-l>", "<cmd>bnext<CR>", { desc = "Next buffer" })
keymap("n", "Q", "<cmd>bdelete<CR>", { desc = "Delete buffer" })

-- 分割窗口
keymap("n", "<leader>sh", "<cmd>vsplit<CR>", { desc = "Split horizontally" })
keymap("n", "<leader>sv", "<cmd>split<CR>", { desc = "Split vertically" })
keymap("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close split" })

--- CSpell：将光标下的错拼单词加入词库（需 cspell_ls + 该处有拼写诊断）
local function cspell_diags_at_cursor()
	local row = vim.api.nvim_win_get_cursor(0)[1] - 1
	local col = vim.api.nvim_win_get_cursor(0)[2]
	local diags = vim.diagnostic.get(0, { pos = { row, col } })
	if #diags == 0 then
		diags = vim.diagnostic.get(0, { lnum = row })
	end
	return vim.tbl_filter(function(d)
		local s = (d.source or ""):lower()
		return s:find("cspell", 1, true) ~= nil
	end, diags)
end

local function cspell_add_to(title)
	return function()
		local diags = cspell_diags_at_cursor()
		if #diags == 0 then
			vim.notify("No cspell diagnostic here — put cursor on the underlined word.", vim.log.levels.WARN)
			return
		end
		-- Must pass LSP Diagnostic[], not vim.Diagnostic[] — otherwise servers return no actions.
		local lsp_diags = vim.lsp.diagnostic.from(diags)
		vim.lsp.buf.code_action({
			context = {
				diagnostics = lsp_diags,
				only = { "quickfix" },
			},
			filter = function(action)
				return (action.title or "") == title
			end,
			apply = true,
		})
	end
end

keymap("n", "<leader>cW", cspell_add_to("Add to workspace words in config"), {
	desc = "CSpell: add word to workspace dictionary",
})
keymap("n", "<leader>cw", cspell_add_to("Add to user words in config"), {
	desc = "CSpell: add word to user dictionary",
})
