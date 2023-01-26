return {
    { "nvim-lua/plenary.nvim" },
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        opts = {
            enable_check_bracket_line = false,
            check_ts = true,
            ts_config = {
                lua = { "string" },
                javascript = { "template_string" },
                java = false,
            },
        },
        config = function(_, opts)
            local autopairs = require("nvim-autopairs")
            local Rule = require("nvim-autopairs.rule")

            -- Apply defined options to nvim-autopairs:
            autopairs.setup(opts)

            -- Use built-in conditions
            local cond = require("nvim-autopairs.conds")
            autopairs.add_rules({
                Rule("(", ")", { "tex", "latex" })
                    :with_pair(cond.not_before_text("\\"))
                    :with_pair(cond.not_before_text("@")),
            })

            autopairs.add_rules({
                Rule("\\(", "\\)", { "tex", "latex" }),
            })

            autopairs.add_rules({
                Rule("\\[", "\\]", { "tex", "latex" }),
            })

            autopairs.add_rules({
                Rule("\\left(", "\\right)", { "tex", "latex" }):with_pair(
                    cond.not_before_text("\\")
                ),
            })

            -- If you want insert `(` after select function or method item
            local cmp = require("cmp")
            local cmp_autopairs = require("nvim-autopairs.completion.cmp")

            cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
        end,
    },
    {
        "zbirenbaum/copilot.lua",
        enabled = false,
        event = "VeryLazy",
        dependencies = { "zbirenbaum/copilot-cmp" },
        opts = {
            suggestion = { enabled = false },
            panel = { enabled = false },
        },
        config = function(_, opts)
            require("copilot").setup(opts)

            -- Tell nvim-cmp to handle copilot completions:
            require("copilot_cmp").setup()
        end,
    },
    {
        "L3MON4D3/LuaSnip",
        event = "InsertEnter",
        dependencies = { "Icy-Thought/friendly-snippets" },
        init = function()
            -- Load custom lua-snippets
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
        end,
        opts = function()
            local types = require("luasnip.util.types")
            return {
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
            }
        end,
        config = function(_, opts)
            require("luasnip").setup(opts)
            require("luasnip.loaders.from_vscode").lazy_load()
        end,
    },
    { "onsails/lspkind-nvim" },
    {
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
        opts = function()
            local cmp = require("cmp")
            local ls = require("luasnip")
            local lspkind = require("lspkind")

            local has_words_before = function()
                local line, col = unpack(vim.api.nvim_win_get_cursor(0))
                return col ~= 0
                    and vim.api
                            .nvim_buf_get_lines(0, line - 1, line, true)[1]
                            :sub(col, col)
                            :match("%s")
                            == nil
            end

            return {
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
                    format = lspkind.cmp_format({
                        mode = "symbol_text",
                        maxwidth = 50,
                        ellipsis_char = "...",
                        before = function(entry, vim_item)
                            -- Surround icons with []
                            vim_item.kind = string.format(
                                "[%s]",
                                lspkind.presets.default[vim_item.kind]
                            )
                            -- Define custom identifiers:
                            vim_item.menu = ({
                                nvim_lsp = "[LSP]",
                                luasnip = "[SNIP]",
                                buffer = "[BUF]",
                                path = "[PATH]",
                            })[entry.source.name]
                            return vim_item
                        end,
                    }),
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
            }
        end,
        config = function(_, opts)
            local cmp = require("cmp")
            cmp.setup(opts)

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
        end,
    },
}
