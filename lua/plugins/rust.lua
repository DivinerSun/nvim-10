local function codelldb_adapter()
	local extension_path = vim.fn.stdpath("data") .. "/mason/packages/codelldb/extension"
	local codelldb_path = extension_path .. "/adapter/codelldb"
	local liblldb_path = extension_path .. "/lldb/lib/liblldb.dylib"

	if vim.fn.executable(codelldb_path) == 0 or vim.fn.filereadable(liblldb_path) == 0 then
		return nil
	end

	return require("rustaceanvim.config").get_codelldb_adapter(codelldb_path, liblldb_path)
end

vim.g.rustaceanvim = function()
	local dap_adapter = codelldb_adapter()
	local opts = {
		tools = {
			test_executor = "background",
		},
		server = {
			capabilities = require("blink.cmp").get_lsp_capabilities(),
			default_settings = {
				["rust-analyzer"] = {
					cargo = {
						allFeatures = true,
					},
					check = {
						command = "clippy",
					},
					completion = {
						callable = {
							snippets = "add_parentheses",
						},
					},
					diagnostics = {
						styleLints = {
							enable = true,
						},
					},
					inlayHints = {
						bindingModeHints = {
							enable = true,
						},
						closureReturnTypeHints = {
							enable = "always",
						},
						lifetimeElisionHints = {
							enable = "skip_trivial",
							useParameterNames = true,
						},
					},
				},
			},
		},
	}

	if dap_adapter then
		opts.dap = {
			adapter = dap_adapter,
		}
	end

	return opts
end

vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("user_rust_keymaps", { clear = true }),
	pattern = "rust",
	callback = function(event)
		local map = function(lhs, rhs, desc)
			vim.keymap.set("n", lhs, rhs, {
				buffer = event.buf,
				desc = desc,
				silent = true,
			})
		end

		map("<leader>rr", function()
			vim.cmd.RustLsp("runnables")
		end, "Rust runnables")
		map("<leader>rR", function()
			vim.cmd.RustLsp({ "runnables", bang = true })
		end, "Rust rerun last runnable")
		map("<leader>rt", function()
			vim.cmd.RustLsp("testables")
		end, "Rust testables")
		map("<leader>rT", function()
			vim.cmd.RustLsp({ "testables", bang = true })
		end, "Rust rerun last testable")
		map("<leader>rd", function()
			vim.cmd.RustLsp("debug")
		end, "Rust debug target")
		map("<leader>rD", function()
			vim.cmd.RustLsp("debuggables")
		end, "Rust debuggables")
		map("<leader>re", function()
			vim.cmd.RustLsp("explainError")
		end, "Rust explain error")
		map("<leader>rm", function()
			vim.cmd.RustLsp("expandMacro")
		end, "Rust expand macro")
		map("<leader>rc", function()
			vim.cmd.RustLsp("openCargo")
		end, "Rust open Cargo.toml")
		map("<leader>rp", function()
			vim.cmd.RustLsp("parentModule")
		end, "Rust parent module")
		map("<leader>rj", function()
			vim.cmd.RustLsp("joinLines")
		end, "Rust join lines")
		map("<leader>rf", function()
			vim.cmd.RustLsp({ "flyCheck", "run" })
		end, "Rust fly check")
	end,
})
