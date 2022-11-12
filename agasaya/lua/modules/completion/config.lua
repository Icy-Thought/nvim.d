local config = {}

function config.lspconfig()
    require("modules.completion.lspconfig")
end

function config.null_ls()
    local nls = require("null-ls")
    local builtins = require("null-ls.builtins")

    nls.setup({
        debounce = 150,
        sources = {
            -------===[ Formatting ]===-------
            builtins.formatting.stylua,
            builtins.formatting.stylish_haskell,
            builtins.formatting.nixpkgs_fmt,
            builtins.formatting.deno_fmt,
            builtins.formatting.black.with({
                extra_args = { "--fast" },
                filetypes = { "python" },
            }),
            builtins.formatting.isort.with({
                extra_args = { "--profile", "black" },
                filetypes = { "python" },
            }),

            -------===[ Code Action ]===-------
            builtins.code_actions.shellcheck,
        },
        on_attach = function(client, bufnr)
            if client.supports_method("textDocument/formatting") then
                vim.api.nvim_create_autocmd("BufWritePre", {
                    buffer = bufnr,
                    callback = function()
                        vim.lsp.buf.format({ bufnr = bufnr })
                    end,
                })
            end
        end,
    })
end

function config.lspsaga()
    require("keymaps.editor.lspsaga")

    local saga = require("lspsaga")
    saga.init_lsp_saga({
        border_style = "rounded",
        code_action_icon = " ",
        diagnostic_header = { " ", " ", " ", " " },
    })
end

function config.nvim_cmp()
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

    local replace_termcodes = function(str)
        return vim.api.nvim_replace_termcodes(str, true, true, true)
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
                    Text = "",
                    Method = "m",
                    Function = "",
                    Constructor = "",
                    Field = "",
                    Variable = "",
                    Class = "",
                    Interface = "",
                    Module = "",
                    Property = "",
                    Unit = "",
                    Value = "",
                    Enum = "",
                    Keyword = "",
                    Snippet = "",
                    Color = "",
                    File = "",
                    Reference = "",
                    Folder = "",
                    EnumMember = "",
                    Constant = "",
                    Struct = "",
                    Event = "",
                    Operator = "",
                    TypeParameter = "",
                }
                vim_item.kind =
                    string.format("%s", lspkind_icons[vim_item.kind])
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
            -- { name = "copilot" },
            { name = "nvim_lsp" },
            { name = "nvim_lua" },
            { name = "luasnip" },
            { name = "path" },
            { name = "buffer" },
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

function config.luasnip()
    local ls = require("luasnip")
    local types = require("luasnip.util.types")

    -- Load installed snippets
    require("luasnip.loaders.from_vscode").lazy_load()

    -- Load custom lua-snippets
    local load_custom_snippets = function()
        local snippets = vim.fn.stdpath("config") .. "/snippets/*lua"
        local paths = vim.split(vim.fn.glob(snippets), "\n")

        --After saving a luasnip file reload it
        vim.api.nvim_create_autocmd("BufWritePost", {
            callback = function()
                dofile(vim.fn.expand("%"))
                require("cmp_luasnip").clear_cache() --reload the cmp source
            end,
            pattern = paths,
        })

        for _, v in ipairs(paths) do
            dofile(v)
        end
    end

    -- Now we load our snippets:
    load_custom_snippets()

    ls.config.set_config({
        delete_check_events = "TextChangedI",
        enable_autosnippets = true,
        ext_opts = {
            [types.choiceNode] = {
                active = {
                    virt_text = { { " ", "Keyword" } },
                },
            },
            [types.insertNode] = {
                active = {
                    virt_text = { { "●", "Special" } },
                },
            },
        },
        history = true,
        region_check_events = "CursorMoved",
        store_selection_keys = "<Tab>",
        updateevents = "TextChanged,TextChangedI,InsertLeave",
    })

    -- Keymaps required for dynamic_node(s)
    local keymap = vim.keymap.set
    local opts = { noremap = true, silent = true }

    keymap({ "i", "s" }, "<C-n>", function()
        if ls.choice_active() then
            ls.change_choice(1)
        end
    end, opts)

    keymap({ "i", "s" }, "<C-p>", function()
        if ls.choice_active() then
            ls.change_choice(-1)
        end
    end, opts)
end

function config.autopairs()
    local npairs = require("nvim-autopairs")
    local Rule = require("nvim-autopairs.rule")

    -- Initialize without config
    npairs.setup()

    -- Use built-in conditions
    local cond = require("nvim-autopairs.conds")
    npairs.add_rules({
        Rule("(", ")", { "tex", "latex" })
            :with_pair(cond.not_before_text("\\"))
            :with_pair(cond.not_before_text("@")),
    })

    npairs.add_rules({
        Rule("\\(", "\\)", { "tex", "latex" }),
    })

    npairs.add_rules({
        Rule("\\[", "\\]", { "tex", "latex" }),
    })

    npairs.add_rules({
        Rule("\\left(", "\\right)", { "tex", "latex" }):with_pair(
            cond.not_before_text("\\")
        ),
    })

    -- If you want insert `(` after select function or method item
    local cmp = require("cmp")
    local cmp_autopairs = require("nvim-autopairs.completion.cmp")

    cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
end

return config
