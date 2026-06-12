local M = {}

-- 支持快捷键的文件类型列表
M.IMPORT_FILETYPES = {
	rust = true,
	javascript = true,
	javascriptreact = true,
	typescript = true,
	typescriptreact = true,
	vue = true,
	python = true,
	go = true,
}

local function notify(msg, level)
	vim.notify(msg, level or vim.log.levels.INFO, { title = "Imports" })
end

-- 通用：按 LSP code action kind 触发（apply=true 时只有一个结果则直接应用，多个则弹出 picker）
local function apply_code_action(only_kinds)
	vim.lsp.buf.code_action({
		apply = true,
		context = { only = only_kinds },
	})
end

-- ─────────────────────────────────────────────────────────────────────────────
-- Rust 专用：通过底层 buf_request 全文件范围请求 code action
-- rust-analyzer 的 "Remove all unused imports" 需要把所有诊断信息放入 context
-- ─────────────────────────────────────────────────────────────────────────────
local function rust_remove_unused()
	local bufnr = vim.api.nvim_get_current_buf()
	local clients = vim.lsp.get_clients({ bufnr = bufnr, name = "rust_analyzer" })
	if #clients == 0 then
		notify("rust-analyzer is not attached to this buffer", vim.log.levels.WARN)
		return
	end
	local client = clients[1]

	-- 收集当前 buffer 所有 LSP 诊断（提供给 rust-analyzer 以定位未使用的导入）
	local lsp_diags = {}
	for _, d in ipairs(vim.diagnostic.get(bufnr)) do
		if d.user_data and d.user_data.lsp then
			table.insert(lsp_diags, d.user_data.lsp)
		end
	end

	if #lsp_diags == 0 then
		notify("No diagnostics found – try building/checking the file first", vim.log.levels.INFO)
		return
	end

	local line_count = vim.api.nvim_buf_line_count(bufnr)
	local params = {
		textDocument = { uri = vim.uri_from_bufnr(bufnr) },
		range = {
			start = { line = 0, character = 0 },
			["end"] = { line = line_count, character = 0 },
		},
		context = {
			only = { "quickfix" },
			diagnostics = lsp_diags,
			triggerKind = 1,
		},
	}

	-- 向 rust_analyzer 发送底层请求（多客户端时只处理 rust_analyzer 的回复）
	vim.lsp.buf_request(bufnr, "textDocument/codeAction", params, function(err, result, ctx)
		local c = vim.lsp.get_client_by_id(ctx.client_id)
		if not c or c.name ~= "rust_analyzer" then
			return
		end
		if err then
			notify("rust-analyzer error: " .. tostring(err.message), vim.log.levels.ERROR)
			return
		end

		for _, action in ipairs(result or {}) do
			local title = action.title:lower()
			if title:find("remove.*unused.*import") or title:find("remove all.*unused") then
				local function do_apply(a)
					if a.edit then
						vim.lsp.util.apply_workspace_edit(a.edit, c.offset_encoding)
						notify("Removed unused imports")
					elseif a.command then
						vim.lsp.buf.execute_command(a.command)
						notify("Removed unused imports")
					end
				end

				if action.edit or action.command then
					do_apply(action)
				else
					-- 部分 action 需要先 resolve 才有 edit
					c.request("codeAction/resolve", action, function(err2, resolved)
						if not err2 and resolved then
							do_apply(resolved)
						end
					end, bufnr)
				end
				return
			end
		end

		notify(
			"No 'remove unused imports' action from rust-analyzer.\n"
				.. "Tip: make sure diagnostics are loaded (try <leader>cf or save first).",
			vim.log.levels.WARN
		)
	end)
end

-- ─────────────────────────────────────────────────────────────────────────────
-- 公开方法
-- ─────────────────────────────────────────────────────────────────────────────

--- <leader>cs：排序 import / use 语句
M.sort_imports = function()
	local ft = vim.bo.filetype

	if ft == "rust" then
		-- rust-analyzer 没有独立的"仅排序"action，给出提示
		notify(
			"rust-analyzer has no sort-only import action.\n"
				.. "Use <leader>co to remove unused imports instead.",
			vim.log.levels.WARN
		)

	elseif ft == "python" then
		-- ruff LSP: source.organizeImports = isort 风格的排序 + 分组
		apply_code_action({ "source.organizeImports.ruff", "source.organizeImports" })

	elseif ft == "go" then
		-- gopls: source.organizeImports = goimports 行为（排序 + 删除未使用）
		apply_code_action({ "source.organizeImports" })

	else
		-- TS / JS / Vue
		-- source.sortImports.ts  ──  仅排序，不删除（TypeScript >= 4.3）
		-- source.organizeImports.ts  ──  排序 + 删除（回退选项）
		apply_code_action({
			"source.sortImports.ts",
			"source.sortImports",
			"source.organizeImports.ts",
			"source.organizeImports",
		})
	end
end

--- <leader>co：删除未使用的 import / use 语句
M.remove_unused_imports = function()
	local ft = vim.bo.filetype

	if ft == "rust" then
		rust_remove_unused()

	elseif ft == "python" then
		-- ruff: source.fixAll 会自动修复所有可自动修复的问题，包括 F401（未使用导入）
		apply_code_action({ "source.fixAll.ruff", "source.fixAll" })

	elseif ft == "go" then
		-- gopls: organizeImports 同时处理排序和删除未使用
		apply_code_action({ "source.organizeImports" })

	else
		-- TS / JS / Vue
		apply_code_action({
			"source.removeUnusedImports.ts",
			"source.removeUnusedImports",
			"source.removeUnused.ts",
			"source.removeUnused",
		})
	end
end

return M
