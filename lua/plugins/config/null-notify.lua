-- Pass notifications from Null-ls.nvim -> Noice.nvim
-- + prevent repetitive notifications from occuring.

local null_ls_token = nil
local ltex_token = nil

vim.lsp.handlers["$/progress"] = function(_, result, ctx)
	local value = result.value
	if not value.kind then
		return
	end

	local client_id = ctx.client_id
	local name = vim.lsp.get_client_by_id(client_id).name

	if name == "null-ls" then
		if result.token == null_ls_token then
			return
		end
		if value.title == "formatting" then
			null_ls_token = result.token
			return
		end
	end

	if name == "ltex" then
		if result.token == ltex_token then
			return
		end
		if value.title == "Checking document" then
			ltex_token = result.token
			return
		end
	end

	vim.notify(value.message, "info", {
		title = value.title,
	})
end
