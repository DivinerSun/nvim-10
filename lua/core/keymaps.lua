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
local function cspell_get_client()
	return vim.lsp.get_clients({ bufnr = 0, name = "cspell_ls" })[1]
end

local function cspell_namespace()
	local client = cspell_get_client()
	return client and vim.lsp.diagnostic.get_namespace(client.id) or nil
end

local function cspell_is_cspell_diag(d, ns)
	if ns and d.namespace == ns then
		return true
	end
	return (d.source or ""):lower():find("cspell", 1, true) ~= nil
end

--- 光标是否落在 diagnostic 的字节范围内
local function cspell_cursor_in_diag(row0, col0, d)
	if d.lnum ~= row0 or (d.end_lnum or d.lnum) ~= row0 or not d.end_col then
		return false
	end
	return col0 >= d.col and col0 < d.end_col
end

--- 精确匹配光标下的 cspell diagnostic（仅 1 条）
local function cspell_diag_at_cursor()
	local row0 = vim.api.nvim_win_get_cursor(0)[1] - 1
	local col0 = vim.api.nvim_win_get_cursor(0)[2]
	local ns = cspell_namespace()
	local get_opts = ns and { namespace = ns } or nil
	local line_diags = {}

	for _, d in ipairs(vim.diagnostic.get(0, get_opts)) do
		if cspell_is_cspell_diag(d, ns) then
			if cspell_cursor_in_diag(row0, col0, d) then
				return d
			end
			if d.lnum == row0 then
				line_diags[#line_diags + 1] = d
			end
		end
	end

	-- 当前行只有一个 cspell 错词时，允许光标略偏（仍在本行）
	if #line_diags == 1 then
		return line_diags[1]
	end

	return nil
end

local function cspell_word_from_diag(d)
	return table.concat(
		vim.api.nvim_buf_get_text(0, d.lnum, d.col, d.end_lnum, d.end_col, {}),
		"\n"
	)
end

local function cspell_lsp_range(d)
	local lsp = d.user_data and d.user_data.lsp
	if lsp and lsp.range then
		return lsp.range
	end
	return {
		start = { line = d.lnum, character = d.col },
		["end"] = { line = d.end_lnum, character = d.end_col },
	}
end

local function cspell_add_to(command)
	return function()
		local d = cspell_diag_at_cursor()
		if not d then
			vim.notify("No cspell diagnostic here — put cursor on the underlined word.", vim.log.levels.WARN)
			return
		end
		local client = cspell_get_client()
		if not client then
			vim.notify("cspell_ls is not attached to this buffer.", vim.log.levels.WARN)
			return
		end
		-- 直接 exec_cmd 并传入当前 diagnostic 的 range，避免 cspell_ls 固定取 diagnostics[0]
		client:exec_cmd({
			command = command,
			arguments = {
				{
					uri = vim.uri_from_bufnr(0),
					range = cspell_lsp_range(d),
					message = d.message,
				},
			},
		})
	end
end

local function cspell_read_json(path)
	local f = io.open(path, "r")
	if not f then
		return {}
	end
	local content = f:read("*a")
	f:close()
	if not content or content:match("^%s*$") then
		return {}
	end
	local ok, cfg = pcall(vim.json.decode, content)
	if not ok or type(cfg) ~= "table" then
		return {}
	end
	return cfg
end

local function cspell_write_json(path, cfg)
	vim.fn.mkdir(vim.fn.fnamemodify(path, ":h"), "p")
	local out = io.open(path, "w")
	if not out then
		return false
	end
	out:write(vim.json.encode(cfg, { indent = "  " }))
	out:write("\n")
	out:close()
	return true
end

local function cspell_add_project()
	local d = cspell_diag_at_cursor()
	if not d then
		vim.notify("No cspell diagnostic here — put cursor on the underlined word.", vim.log.levels.WARN)
		return
	end
	local word = cspell_word_from_diag(d)
	local root = vim.fs.root(0, { ".git", "cspell.json", "package.json", "Cargo.toml" })
	if not root then
		vim.notify("Cannot find project root for cspell.json", vim.log.levels.WARN)
		return
	end
	local path = root .. "/cspell.json"
	local cfg = cspell_read_json(path)
	cfg.words = cfg.words or {}
	if not vim.tbl_contains(cfg.words, word) then
		table.insert(cfg.words, word)
		table.sort(cfg.words)
	end
	if cspell_write_json(path, cfg) then
		vim.notify('Added "' .. word .. '" to project cspell', vim.log.levels.INFO)
	end
end

keymap("n", "<leader>cW", cspell_add_project, {
	desc = "CSpell: add word to workspace dictionary",
})
keymap("n", "<leader>cw", cspell_add_to("AddToUserWordsConfig"), {
	desc = "CSpell: add word to user global dictionary",
})
