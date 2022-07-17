local utils = require("utils")

utils.nnoremap(
    "<leader>tp",
    "<CMD>lua _PYTHON_TOGGLE()<CR>",
    { desc = "Python TermEnv" }
)
utils.nnoremap(
    "<leader>tf",
    "<CMD>ToggleTerm direction=float<CR>",
    { desc = "Floating Terminal" }
)
utils.nnoremap(
    "<leader>th",
    "<CMD>ToggleTerm size=10 direction=horizontal<CR>",
    { desc = "Horizontal Terminal" }
)
utils.nnoremap(
    "<leader>tt",
    "<CMD>ToggleTerm direction=tab<CR>",
    { desc = "Tabbed Terminal" }
)
utils.nnoremap(
    "<leader>tv",
    "<CMD>ToggleTerm size=80 direction=vertical<CR>",
    { desc = "Vertical Terminal" }
)

local maps = {
    t = { name = "Terminal" },
}

require("which-key").register(maps)
