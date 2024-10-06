local Hydra = require("hydra")

local align_hint = [[
  ^^                       Session Manager                         ^
  ^
  ^^  _l_: List Sessions                 _d_: Delete Session        ^
  ^^  _n_: New Session                   _u_: Update Sessions       ^
  ^
  ^^                                               _q_: Quit! ^
]]

local possession = require("nvim-possession")

Hydra({
	name = "nvim-possession",
	hint = align_hint,
	config = {
		color = "teal",
		invoke_on_body = true,
		hint = {
			border = "rounded",
			position = "middle",
		},
	},
	mode = "n",
	body = "<leader>s",
	heads = {
		{
			"l",
			function()
				possession.list()
			end,
			{ desc = "List existing sessions" },
		},
		{
			"d",
			function()
				possession.delete()
			end,
			{ desc = "Delete current session" },
		},
		{
			"n",
			function()
				possession.update()
			end,
			{ desc = "Name & create new session" },
		},
		{
			"u",
			function()
				possession.update()
			end,
			{ desc = "Update current sessions" },
		},
		{ "q", nil, { exit = true, nowait = true, desc = "Exit" } },
	},
})
