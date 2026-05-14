local neotest = require("neotest")

neotest.setup({
	adapters = {
		require("rustaceanvim.neotest"),
	},
})

vim.keymap.set("n", "<leader>tn", function()
	neotest.run.run()
end, { desc = "Test nearest" })

vim.keymap.set("n", "<leader>tf", function()
	neotest.run.run(vim.fn.expand("%"))
end, { desc = "Test file" })

vim.keymap.set("n", "<leader>td", function()
	neotest.run.run({
		strategy = "dap",
	})
end, { desc = "Debug nearest test" })

vim.keymap.set("n", "<leader>ts", neotest.summary.toggle, { desc = "Test summary" })
vim.keymap.set("n", "<leader>to", function()
	neotest.output.open({
		enter = true,
		auto_close = true,
	})
end, { desc = "Test output" })
