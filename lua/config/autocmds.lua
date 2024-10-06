local autocmds = {}

local aucmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

function autocmds.load_autocmds()
	-- Create dir on save if != existent
	aucmd("BufWritePre", {
		group = augroup("auto_create_dir", { clear = true }),
		callback = function(event)
			local file = vim.loop.fs_realpath(event.match) or event.match
			local backup = vim.fn.fnamemodify(file, ":p:~:h")

			vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
			backup = backup:gsub("[/\\]", "%%")
			vim.go.backupext = backup
		end,
	})

	-- Auto move to the location of the last edit
	aucmd("BufReadPost", {
		group = augroup("jump_to_last_position", { clear = true }),
		callback = function()
			if
				not vim.fn.expand("%:p"):match(".git")
				and vim.fn.line("'\"") > 1
				and vim.fn.line("'\"") <= vim.fn.line("$")
			then
				vim.cmd("normal! g'\"")
				vim.cmd("normal zz")
			end
		end,
	})

	-- Highlight yanked text
	aucmd("TextYankPost", {
		group = augroup("highlight_yanked_text", { clear = true }),
		pattern = "*",
		callback = function()
			vim.highlight.on_yank({
				higroup = "IncSearch",
				timeout = 50,
			})
		end,
	})

	-- Auto change directory
	aucmd("BufEnter", {
		group = augroup("autocd_on_bufenter", { clear = true }),
		pattern = "*",
		command = "silent! lcd %:p:h",
	})

	-- Force write shada when nvim == idle!
	aucmd({ "CursorHold", "TextYankPost", "FocusGained", "FocusLost" }, {
		group = augroup("autocd_on_enter", { clear = true }),
		pattern = "*",
		callback = function()
			if vim.fn.exists("rshada") == 1 then
				vim.cmd("rshada")
				vim.cmd("wshada")
			end
		end,
	})

	-- Check file status for focused window (more eager than 'autoread')
	aucmd("FocusGained", {
		group = augroup("eager_autoread", { clear = true }),
		pattern = "*",
		command = "checktime",
	})

	-- Equalize window dimensions when resizing vim window
	aucmd("VimResized", {
		group = augroup("appropriate_resizing", { clear = true }),
		pattern = "*",
		command = "tabdo wincmd =",
	})

	-- Limit text-width to 80 chars for documentation formats
	aucmd("FileType", {
		group = augroup("text_width_limiter", { clear = true }),
		pattern = "markdown,norg",
		callback = function()
			if not vim.g.neovide then
				vim.o.textwidth = 80
			else
				vim.o.textwidth = 120
			end
		end,
	})
end

autocmds.load_autocmds()
