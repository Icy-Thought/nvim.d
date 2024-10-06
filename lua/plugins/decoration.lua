return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		lazy = false,
		priority = 1000,
		opts = {
			flavour = "mocha",
			background = {
				light = "latte",
				dark = "mocha",
			},
			transparent_background = true,
			term_colors = true,
			styles = {
				comments = { "italic" },
				functions = { "italic", "bold" },
				keywords = { "italic" },
				strings = {},
				variables = {},
			},
			integrations = {
				bufferline = true,
				gitsigns = true,
				indent_blankline = {
					colored_indent_levels = true,
				},
				-- lightspeed = false,
				lsp_saga = true,
				lsp_trouble = true,
				neogit = true,
				notify = true,
				neotree = true,
				nvimtree = false,
			},
		},
		config = function(_, opts)
			require("catppuccin").setup(opts)
			vim.g.catppuccin_flavour = "mocha"

			if not vim.g.neovide then
				require("lualine").setup({
					options = { theme = "catppuccin" },
				})
				vim.cmd("colorscheme catppuccin")
			end
		end,
	},
	{
		"projekt0n/github-nvim-theme",
		tag = "v0.0.7",
		lazy = false,
		priority = 1000,
		opts = {
			dark_float = true,
			theme_style = "dark_default",
			transparent = false,
			comment_style = "italic",
			keyword_style = "italic",
			function_style = "italic",
			overrides = function()
				return { BufferLineBackground = {} }
			end,
		},
		config = function(_, opts)
			if vim.g.neovide then
				require("github-theme").setup(opts)
			end
		end,
	},
	{
		"rebelot/kanagawa.nvim",
		build = ":KanagawaCompile",
		enabled = false,
		lazy = false,
		priority = 1000,
		opts = {
			compile = true,
			transparent = true,
		},
		config = function(_, opts)
			require("kanagawa").setup(opts)

			if not vim.g.neovide then
				require("lualine").setup({
					options = { theme = "kanagawa" },
				})
				vim.cmd("colorscheme kanagawa")
			end
		end,
	},

	{
		"nyoom-engineering/oxocarbon.nvim",
		enabled = false,
		lazy = false,
		priority = 1000,
		config = function()
			if vim.g.neovide then
				vim.cmd("colorscheme oxocarbon")
			end
		end,
	},
	{
		"rose-pine/neovim",
		name = "rose-pine",
		enabled = false,
		lazy = false,
		priority = 1000,
		opts = {
			disable_background = true,
		},
		config = function(_, opts)
			require("rose-pine").setup(opts)

			if not vim.g.neovide then
				require("lualine").setup({
					options = { theme = "rose-pine" },
				})
				vim.cmd("colorscheme rose-pine")
			end
		end,
	},
	{
		"folke/tokyonight.nvim",
		enabled = false,
		lazy = false,
		priority = 1000,
		opts = {
			style = "night",
			transparent = true,
			terminal_colors = true,
			styles = {
				comments = { italic = true },
				functions = { italic = true, bold = true },
				keywords = { italic = true },
				variables = {},
				sidebars = "dark",
				floats = "dark",
			},
			sidebars = { "qf", "help", "terminal", "packer" },
			day_brightness = 0.3,
			hide_inactive_statusline = false,
			dim_inactive = false,
		},
		config = function(_, opts)
			require("tokyonight").setup(opts)

			if not vim.g.neovide then
				require("lualine").setup({
					options = { theme = "tokyonight" },
				})
				vim.cmd("colorscheme tokyonight")
			end
		end,
	},
}
