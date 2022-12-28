local M = {
    "zbirenbaum/copilot.lua",
    enabled = false,
    event = "VeryLazy",
}

function M.config()
    vim.defer_fn(function()
        require("copilot").setup()
    end, 100)

    require("copilot_cmp").setup()
end

return M
