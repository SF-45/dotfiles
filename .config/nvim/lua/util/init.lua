local M = {}

M.map = function(mode, rhs, lhs, desc, opts)
	if opts == nil then
		opts = {}
	end
	if desc ~= nil then
		opts.desc = desc
	end
	vim.keymap.set(mode, rhs, lhs, opts)
end

function M.augroup(name)
	return vim.api.nvim_create_augroup("SF-45_" .. name, { clear = true })
end
function M.copyTable(orig)
	local copy
	if type(orig) == "table" then
		copy = {}
		for orig_key, orig_value in next, orig, nil do
			copy[M.copyTable(orig_key)] = M.copyTable(orig_value)
		end
		setmetatable(copy, M.copyTable(getmetatable(orig)))
	else
		copy = orig
	end
	return copy
end

function M.register_autocmd(event, opts)
  if type(opts.group) == "string" then
    opts.group = M.augroup(opts.group)
  end
  vim.api.nvim_create_autocmd(event, opts)
end
return M
