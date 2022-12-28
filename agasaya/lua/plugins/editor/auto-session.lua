local M = {
    enabled = false,
    "rmagatti/auto-session",
    cmd = { "SaveSession", "RestoreSession", "DeleteSession" },
}

function M.config()
    local auto_session = require("auto-session")
    auto_session.setup({
        log_level = "info",
        auto_session_enable_last_session = true,
        auto_session_root_dir = vim.fn.stdpath("data") .. "/sessions/",
        auto_session_enabled = true,
        auto_save_enabled = true,
        auto_restore_enabled = true,
        auto_session_suppress_dirs = nil,
    })
end

return M
