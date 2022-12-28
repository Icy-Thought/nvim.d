local M = {
    "hrsh7th/nvim-cmp",
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = {
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-nvim-lua",
        "hrsh7th/cmp-path",
        "saadparwaiz1/cmp_luasnip",
    },
}

function M.config()
    local cmp = require("cmp")
    local ls = require("luasnip")

    local has_words_before = function()
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0
            and vim.api
                    .nvim_buf_get_lines(0, line - 1, line, true)[1]
                    :sub(col, col)
                    :match("%s")
                == nil
    end

    cmp.setup({
        experimental = {
            ghost_text = false,
            native_menu = false,
        },
        window = {
            completion = cmp.config.window.bordered(),
            documentation = cmp.config.window.bordered(),
        },
        formatting = {
            fields = { "kind", "abbr", "menu" },
            format = function(entry, vim_item)
                local lspkind_icons = {
                    Text = " ",
                    Method = " ",
                    Function = " ",
                    Constructor = " ",
                    Field = " ",
                    Variable = " ",
                    Class = " ",
                    Interface = " ",
                    Module = " ",
                    Property = " ",
                    Unit = " ",
                    Value = " ",
                    Enum = " ",
                    Keyword = " ",
                    Snippet = " ",
                    Color = " ",
                    File = " ",
                    Reference = " ",
                    Folder = " ",
                    EnumMember = " ",
                    Constant = " ",
                    Struct = " ",
                    Event = " ",
                    Operator = " ",
                    TypeParameter = " ",
                }
                vim_item.kind =
                    string.format("[%s]", lspkind_icons[vim_item.kind])
                vim_item.menu = ({
                    nvim_lsp = "[LSP]",
                    luasnip = "[SNIP]",
                    buffer = "[BUF]",
                    path = "[PATH]",
                })[entry.source.name]
                return vim_item
            end,
        },
        mapping = cmp.mapping.preset.insert({
            ["<CR>"] = cmp.mapping.confirm({ select = true }),
            ["<C-k>"] = cmp.mapping.select_prev_item(),
            ["<C-j>"] = cmp.mapping.select_next_item(),
            ["<C-b>"] = cmp.mapping.scroll_docs(-4),
            ["<C-f>"] = cmp.mapping.scroll_docs(4),
            ["<C-e>"] = cmp.mapping.close(),
            ["<Tab>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_next_item()
                elseif ls.expand_or_jumpable() then
                    ls.expand_or_jump()
                elseif has_words_before() then
                    return cmp.complete()
                else
                    fallback()
                end
            end, { "i", "s" }),
            ["<S-Tab>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_prev_item()
                elseif ls.jumpable(-1) then
                    ls.jump(-1)
                else
                    fallback()
                end
            end, { "i", "s" }),
        }),
        snippet = {
            expand = function(args)
                ls.lsp_expand(args.body)
            end,
        },
        sources = {
            { name = "nvim_lsp" },
            { name = "nvim_lua" },
            { name = "luasnip" },
            { name = "path" },
            { name = "buffer" },
            { name = "orgmode" },
        },
    })

    -- Use buffer source for `/` and `?`
    cmp.setup.cmdline({ "/", "?", ":%s/" }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
            { name = "buffer" },
        },
    })

    -- Use cmdline & path source for ':'
    cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
            { name = "path" },
            { name = "cmdline" },
        }),
    })
end

return M
