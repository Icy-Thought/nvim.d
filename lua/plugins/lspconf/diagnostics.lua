local M = {}

function M.setup()
	vim.diagnostic.config({
		float = {
			focusable = false,
			style = "minimal",
			border = "rounded",
			source = "always",
			header = "",
			prefix = "",
		},
		severity_sort = true,
		signs = true,
		underline = true,
		update_in_insert = true,
		virtual_text = {
			source = "always",
			prefix = "▎",
		},
	})

	local signs = {
		Error = " ",
		Warn = " ",
		Info = " ",
		Hint = "ﴞ ",
	}

	for type, icon in pairs(signs) do
		local hl = "DiagnosticSign" .. type
		vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
	end

	-- Override border style globally (Rounded)
	local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview

	function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
		opts = opts or {}
		opts.border = opts.border or "rounded"
		return orig_util_open_floating_preview(contents, syntax, opts, ...)
	end
end

return M
