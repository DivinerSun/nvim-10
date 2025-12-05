local M = {}

local is_diagnostics_enabled = true
M.toggle_lsp_diagnostics = function()
	is_diagnostics_enabled = not is_diagnostics_enabled
	vim.diagnostic.config({ virtual_text = is_diagnostics_enabled, underline = is_diagnostics_enabled })
end

return M
