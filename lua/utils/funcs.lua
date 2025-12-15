local M = {}

local LazyUtil = require("lazy.core.util")
for _, level in ipairs({ "info", "warn", "error" }) do
	M[level] = function(msg, opts)
		opts = opts or {}
		opts.title = opts.title or "Func from LazyVim"
		return LazyUtil[level](msg, opts)
	end
end

local is_diagnostics_enabled = true
M.toggle_lsp_diagnostics = function()
	is_diagnostics_enabled = not is_diagnostics_enabled
	vim.diagnostic.config({ virtual_text = is_diagnostics_enabled, underline = is_diagnostics_enabled })
end

-- ================ From LazyVim Func Start ================

M.set = function(filter, spec)
	local Keys = require("lazy.core.handler.keys")
	for _, keys in pairs(Keys.resolve(spec)) do
		---@cast keys LazyKeysLsp
		local filters = {} ---@type vim.lsp.get_clients.Filter[]
		if keys.has then
			local methods = type(keys.has) == "string" and { keys.has } or keys.has --[[@as string[] ]]
			for _, method in ipairs(methods) do
				method = method:find("/") and method or ("textDocument/" .. method)
				filters[#filters + 1] = vim.tbl_extend("force", vim.deepcopy(filter), { method = method })
			end
		else
			filters[#filters + 1] = filter
		end

		for _, f in ipairs(filters) do
			local opts = Keys.opts(keys)
			---@cast opts snacks.keymap.set.Opts
			opts.lsp = f
			opts.enabled = keys.enabled
			Snacks.keymap.set(keys.mode or "n", keys.lhs, keys.rhs, opts)
		end
	end
end

M.action = setmetatable({}, {
	__index = function(_, action)
		return function()
			vim.lsp.buf.code_action({
				apply = true,
				context = {
					only = { action },
					diagnostics = {},
				},
			})
		end
	end,
})

M.get_plugin = function(name)
	return require("lazy.core.config").spec.plugins[name]
end

M.has = function(plugin)
	return M.get_plugin(plugin) ~= nil
end

M.opts = function(name)
	local plugin = M.get_plugin(name)
	if not plugin then
		return {}
	end
	local Plugin = require("lazy.core.plugin")
	return Plugin.values(plugin, "opts", false)
end

M.format = function(opts)
	opts = vim.tbl_deep_extend(
		"force",
		{},
		opts or {},
		M.opts("nvim-lspconfig").format or {},
		M.opts("conform.nvim").format or {}
	)
	local ok, conform = pcall(require, "conform")
	if ok then
		opts.formatters = {}
		conform.format(opts)
	else
		vim.lsp.buf.format(opts)
	end
end

M.formatter = function(opts)
	local merge = require("lazy.core.util").merge

	opts = opts or {}
	local filter = opts.filter or {}
	filter = type(filter) == "string" and { name = filter } or filter
	local ret = {
		name = "LSP",
		primary = true,
		priority = 1,
		format = function(buf)
			M.format(merge({}, filter, { bufnr = buf }))
		end,
		sources = function(buf)
			local clients = vim.lsp.get_clients(merge({}, filter, { bufnr = buf }))
			local ret = vim.tbl_filter(function(client)
				return client:supports_method("textDocument/formatting")
					or client:supports_method("textDocument/rangeFormatting")
			end, clients)
			return vim.tbl_map(function(client)
				return client.name
			end, ret)
		end,
	}
	return merge(ret, opts)
end

M.deprecate = function(old, new, opts)
	M.warn(
		("`%s` is deprecated. Please use `%s` instead"):format(old, new),
		vim.tbl_extend("force", {
			title = "Func from LazyVim",
			once = true,
			stacktrace = true,
			stacklevel = 6,
		}, opts or {})
	)
end

local _defaults = {}
M.set_default = function(option, value)
	local l = vim.api.nvim_get_option_value(option, { scope = "local" })
	local g = vim.api.nvim_get_option_value(option, { scope = "global" })

	_defaults[("%s=%s"):format(option, value)] = true
	local key = ("%s=%s"):format(option, l)

	local source = ""
	if l ~= g and not _defaults[key] then
		-- Option does not match global and is not a default value
		-- Check if it was set by a script in $VIMRUNTIME
		local info = vim.api.nvim_get_option_info2(option, { scope = "local" })
		---@param e vim.fn.getscriptinfo.ret
		local scriptinfo = vim.tbl_filter(function(e)
			return e.sid == info.last_set_sid
		end, vim.fn.getscriptinfo())
		source = scriptinfo[1] and scriptinfo[1].name or ""
		local by_rtp = #scriptinfo == 1 and vim.startswith(scriptinfo[1].name, vim.fn.expand("$VIMRUNTIME"))
		if not by_rtp then
			if vim.g.lazyvim_debug_set_default then
				M.warn(
					("Not setting option `%s` to `%q` because it was changed by a plugin."):format(option, value),
					{ title = "Func from LazyVim", once = true }
				)
			end
			return false
		end
	end

	if vim.g.lazyvim_debug_set_default then
		Func.info({
			("Setting option `%s` to `%q`"):format(option, value),
			("Was: %q"):format(l),
			("Global: %q"):format(g),
			source ~= "" and ("Last set by: %s"):format(source) or "",
			"buf: " .. vim.api.nvim_buf_get_name(0),
		}, { title = "Func from LazyVim", once = true })
	end

	vim.api.nvim_set_option_value(option, value, { scope = "local" })
	return true
end

M.formatters = {}

M.register = function(formatter)
	M.formatters[#M.formatters + 1] = formatter
	table.sort(M.formatters, function(a, b)
		return a.priority > b.priority
	end)
end

-- treesitter
M._installed = nil
M._queries = {}

M.get_installed = function(update)
	if update then
		M._installed, M._queries = {}, {}
		for _, lang in ipairs(require("nvim-treesitter").get_installed("parsers")) do
			M._installed[lang] = true
		end
	end
	return M._installed or {}
end

M.have_query = function(lang, query)
	local key = lang .. ":" .. query
	if M._queries[key] == nil then
		M._queries[key] = vim.treesitter.query.get(lang, query) ~= nil
	end
	return M._queries[key]
end

M.have = function(what, query)
	what = what or vim.api.nvim_get_current_buf()
	what = type(what) == "number" and vim.bo[what].filetype or what
	local lang = vim.treesitter.language.get_lang(what)
	if lang == nil or M.get_installed()[lang] == nil then
		return false
	end
	if query and not M.have_query(lang, query) then
		return false
	end
	return true
end

-- mini

M.ai_buffer = function(ai_type)
	local start_line, end_line = 1, vim.fn.line("$")
	if ai_type == "i" then
		local first_nonblank, last_nonblank = vim.fn.nextnonblank(start_line), vim.fn.prevnonblank(end_line)
		if first_nonblank == 0 or last_nonblank == 0 then
			return { from = { line = start_line, col = 1 } }
		end
		start_line, end_line = first_nonblank, last_nonblank
	end

	local to_col = math.max(vim.fn.getline(end_line):len(), 1)
	return { from = { line = start_line, col = 1 }, to = { line = end_line, col = to_col } }
end

M.ai_whichkey = function(opts)
	local objects = {
		{ " ", desc = "whitespace" },
		{ '"', desc = '" string' },
		{ "'", desc = "' string" },
		{ "(", desc = "() block" },
		{ ")", desc = "() block with ws" },
		{ "<", desc = "<> block" },
		{ ">", desc = "<> block with ws" },
		{ "?", desc = "user prompt" },
		{ "U", desc = "use/call without dot" },
		{ "[", desc = "[] block" },
		{ "]", desc = "[] block with ws" },
		{ "_", desc = "underscore" },
		{ "`", desc = "` string" },
		{ "a", desc = "argument" },
		{ "b", desc = ")]} block" },
		{ "c", desc = "class" },
		{ "d", desc = "digit(s)" },
		{ "e", desc = "CamelCase / snake_case" },
		{ "f", desc = "function" },
		{ "g", desc = "entire file" },
		{ "i", desc = "indent" },
		{ "o", desc = "block, conditional, loop" },
		{ "q", desc = "quote `\"'" },
		{ "t", desc = "tag" },
		{ "u", desc = "use/call" },
		{ "{", desc = "{} block" },
		{ "}", desc = "{} with ws" },
	}

	local ret = { mode = { "o", "x" } }
	local mappings = vim.tbl_extend("force", {}, {
		around = "a",
		inside = "i",
		around_next = "an",
		inside_next = "in",
		around_last = "al",
		inside_last = "il",
	}, opts.mappings or {})
	mappings.goto_left = nil
	mappings.goto_right = nil

	for name, prefix in pairs(mappings) do
		name = name:gsub("^around_", ""):gsub("^inside_", "")
		ret[#ret + 1] = { prefix, group = name }
		for _, obj in ipairs(objects) do
			local desc = obj.desc
			if prefix:sub(1, 1) == "i" then
				desc = desc:gsub(" with ws", "")
			end
			ret[#ret + 1] = { prefix .. obj[1], desc = obj.desc }
		end
	end
	require("which-key").add(ret, { notify = false })
end

M.pairs = function(opts)
	Snacks.toggle({
		name = "Mini Pairs",
		get = function()
			return not vim.g.minipairs_disable
		end,
		set = function(state)
			vim.g.minipairs_disable = not state
		end,
	}):map("<leader>up")

	local pairs = require("mini.pairs")
	pairs.setup(opts)
	local open = pairs.open
	pairs.open = function(pair, neigh_pattern)
		if vim.fn.getcmdline() ~= "" then
			return open(pair, neigh_pattern)
		end
		local o, c = pair:sub(1, 1), pair:sub(2, 2)
		local line = vim.api.nvim_get_current_line()
		local cursor = vim.api.nvim_win_get_cursor(0)
		local next = line:sub(cursor[2] + 1, cursor[2] + 1)
		local before = line:sub(1, cursor[2])
		if opts.markdown and o == "`" and vim.bo.filetype == "markdown" and before:match("^%s*``") then
			return "`\n```" .. vim.api.nvim_replace_termcodes("<up>", true, true, true)
		end
		if opts.skip_next and next ~= "" and next:match(opts.skip_next) then
			return o
		end
		if opts.skip_ts and #opts.skip_ts > 0 then
			local ok, captures = pcall(vim.treesitter.get_captures_at_pos, 0, cursor[1] - 1, math.max(cursor[2] - 1, 0))
			for _, capture in ipairs(ok and captures or {}) do
				if vim.tbl_contains(opts.skip_ts, capture.capture) then
					return o
				end
			end
		end
		if opts.skip_unbalanced and next == c and c ~= o then
			local _, count_open = line:gsub(vim.pesc(pair:sub(1, 1)), "")
			local _, count_close = line:gsub(vim.pesc(pair:sub(2, 2)), "")
			if count_close > count_open then
				return o
			end
		end
		return open(pair, neigh_pattern)
	end
end

-- LazyVim init
M.is_loaded = function(name)
	local Config = require("lazy.core.config")
	return Config.plugins[name] and Config.plugins[name]._.loaded
end

M.on_load = function(name, fn)
	if M.is_loaded(name) then
		fn(name)
	else
		vim.api.nvim_create_autocmd("User", {
			pattern = "LazyLoad",
			callback = function(event)
				if event.data == name then
					fn(name)
					return true
				end
			end,
		})
	end
end

-- ================ From LazyVim Func Start ================

return M
