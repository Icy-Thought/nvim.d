-- @akinsho
-- https://github.com/akinsho/dotfiles/blob/5e5d579742f0edcd63c5b6e6c210a95242a35feb/.config/nvim/lua/as/globals.lua#L232

local utils = {}

local function create_keymap(mode, o)
    local parent_opts = vim.deepcopy(o)

    return function(lhs, rhs, opts)
        opts = type(opts) == "string" and { desc = opts }
            or opts and vim.deepcopy(opts)
            or {}
        vim.keymap.set(
            mode,
            lhs,
            rhs,
            vim.tbl_extend("keep", opts, parent_opts)
        )
    end
end

local map_opts = { remap = true, silent = true }
utils.nmap = create_keymap("n", map_opts)
utils.xmap = create_keymap("x", map_opts)
utils.imap = create_keymap("i", map_opts)
utils.vmap = create_keymap("v", map_opts)
utils.omap = create_keymap("o", map_opts)
utils.tmap = create_keymap("t", map_opts)
utils.smap = create_keymap("s", map_opts)
utils.cmap = create_keymap("c", map_opts)

local noremap_opts = { noremap = true, silent = true }
utils.nnoremap = create_keymap("n", noremap_opts)
utils.xnoremap = create_keymap("x", noremap_opts)
utils.inoremap = create_keymap("i", noremap_opts)
utils.vnoremap = create_keymap("v", noremap_opts)
utils.onoremap = create_keymap("o", noremap_opts)
utils.tnoremap = create_keymap("t", noremap_opts)
utils.snoremap = create_keymap("s", noremap_opts)
utils.cnoremap = create_keymap("c", noremap_opts)

return utils
