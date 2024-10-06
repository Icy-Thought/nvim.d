return {
	{
		"kawre/leetcode.nvim",
		build = ":TSUpdate html",
		dependencies = {
			"MunifTanjim/nui.nvim",
			"nvim-lua/plenary.nvim", -- required by telescope
			"nvim-telescope/telescope.nvim",
			"nvim-tree/nvim-web-devicons",
			"nvim-treesitter/nvim-treesitter",
		},
		opts = {
			lang = "rust",
			-- sql = "postgresql"
		},
		config = function(_, opts)
			vim.keymap.set("n", "<leader>lq", "<cmd>LcQuestionTabs<cr>")
			vim.keymap.set("n", "<leader>lm", "<cmd>LcMenu<cr>")
			vim.keymap.set("n", "<leader>lc", "<cmd>LcConsole<cr>")
			vim.keymap.set("n", "<leader>ll", "<cmd>LcLanguage<cr>")
			vim.keymap.set("n", "<leader>ld", "<cmd>LcDescriptionToggle<cr>")

			require("leetcode").setup(opts)
		end,
	},
}
