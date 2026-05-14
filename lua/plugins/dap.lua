local dap = require("dap")
local dapui = require("dapui")

dapui.setup({
	controls = {
		enabled = true,
	},
	floating = {
		border = "rounded",
	},
})

dap.listeners.after.event_initialized["dapui_config"] = function()
	dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
	dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
	dapui.close()
end

vim.keymap.set("n", "<F5>", dap.continue, { desc = "DAP continue" })
vim.keymap.set("n", "<F10>", dap.step_over, { desc = "DAP step over" })
vim.keymap.set("n", "<F11>", dap.step_into, { desc = "DAP step into" })
vim.keymap.set("n", "<F12>", dap.step_out, { desc = "DAP step out" })
vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "DAP toggle breakpoint" })
vim.keymap.set("n", "<leader>dB", function()
	dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
end, { desc = "DAP conditional breakpoint" })
vim.keymap.set("n", "<leader>dl", function()
	dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
end, { desc = "DAP log point" })
vim.keymap.set("n", "<leader>dr", dap.repl.open, { desc = "DAP open REPL" })
vim.keymap.set("n", "<leader>du", dapui.toggle, { desc = "DAP toggle UI" })
