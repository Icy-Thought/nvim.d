local M = {
    "nvim-orgmode/orgmode",
    ft = "org",
}

function M.config()
    local org_mode = require("orgmode")

    org_mode.setup_ts_grammar()
    org_mode.setup({
        org_agenda_files = { "~/Notes/Org-Mode/*" },
        org_default_notes_file = "~/Notes/Org-Mode/refile.org",
    })
end

return M
