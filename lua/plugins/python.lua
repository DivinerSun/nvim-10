local capabilities = require("blink.cmp").get_lsp_capabilities()

-- basedpyright: 类型检查、补全、跳转
vim.lsp.config("basedpyright", {
	capabilities = capabilities,
	settings = {
		basedpyright = {
			analysis = {
				typeCheckingMode = "standard",
				autoSearchPaths = true,
				useLibraryCodeForTypes = true,
				diagnosticMode = "openFilesOnly",
			},
		},
	},
})
vim.lsp.enable("basedpyright")

-- ruff: lint 诊断 + quick fix 代码操作（不提供补全，与 basedpyright 互补）
vim.lsp.config("ruff", {
	capabilities = capabilities,
	init_options = {
		settings = {
			lineLength = 120,
		},
	},
})
vim.lsp.enable("ruff")

-- 在 Python 文件里禁止 ruff LSP 的 hover（让 basedpyright 负责文档）
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("user_python_lsp_attach", { clear = true }),
	callback = function(event)
		local client = vim.lsp.get_client_by_id(event.data.client_id)
		if client and client.name == "ruff" then
			client.server_capabilities.hoverProvider = false
		end
	end,
})

-- ── debugpy DAP 配置 ────────────────────────────────────────────────────────
local dap = require("dap")

-- debugpy adapter（通过 mason 安装的 debugpy）
dap.adapters.python = function(cb, config)
	if config.request == "attach" then
		local port = (config.connect or config).port
		local host = (config.connect or config).host or "127.0.0.1"
		cb({
			type = "server",
			port = assert(port, "`config.connect.port` is required for python attach"),
			host = host,
			options = { source_filetype = "python" },
		})
	else
		cb({
			type = "executable",
			command = vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python",
			args = { "-m", "debugpy.adapter" },
			options = { source_filetype = "python" },
		})
	end
end

-- 优先使用当前激活的虚拟环境
local function python_path()
	local venv = vim.env.VIRTUAL_ENV or vim.env.CONDA_PREFIX
	if venv then
		return venv .. "/bin/python"
	end
	local python3 = vim.fn.exepath("python3")
	if python3 ~= "" then
		return python3
	end
	return vim.fn.exepath("python") ~= "" and vim.fn.exepath("python") or "python"
end

dap.configurations.python = {
	{
		type = "python",
		request = "launch",
		name = "Launch file",
		program = "${file}",
		pythonPath = python_path,
	},
	{
		type = "python",
		request = "launch",
		name = "Launch file with args",
		program = "${file}",
		args = function()
			local args = vim.fn.input("Program args: ")
			return vim.split(args, " ", { trimempty = true })
		end,
		pythonPath = python_path,
	},
	{
		type = "python",
		request = "launch",
		name = "Launch module",
		module = function()
			return vim.fn.input("Module name: ")
		end,
		pythonPath = python_path,
	},
}

-- ── Python buffer 快捷键 ────────────────────────────────────────────────────
vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("user_python_keymaps", { clear = true }),
	pattern = "python",
	callback = function(event)
		local map = function(lhs, rhs, desc)
			vim.keymap.set("n", lhs, rhs, { buffer = event.buf, desc = desc, silent = true })
		end

		-- 运行当前文件（在下方 split terminal）
		map("<leader>rp", function()
			vim.cmd("split | terminal python3 " .. vim.fn.expand("%:p"))
		end, "Python: run file")

		-- 启动调试
		map("<leader>dp", function()
			require("dap").continue()
		end, "Python: debug")

		-- 选择调试配置并运行
		map("<leader>dP", function()
			require("dap").run(require("dap").configurations.python[vim.fn.inputlist(vim.tbl_map(function(c)
				return c.name
			end, require("dap").configurations.python))])
		end, "Python: pick debug config")
	end,
})
