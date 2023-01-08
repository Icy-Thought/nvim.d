return {
    {
        "jackMort/ChatGPT.nvim",
        event = "UIEnter",
        config = function()
            require("chatgpt").setup({
                chat_window = {
                    border = { text = { top = "ChatGPT-3" } },
                },
            })
        end,
    },
    {
        "gorbit99/codewindow.nvim",
        event = "BufReadPost",
        config = true,
    },
    {
        "lewis6991/gitsigns.nvim",
        ft = "gitcommit",
        event = "BufReadPost",
        config = function()
            require("gitsigns").setup()
            require("keymaps.editor.gitsigns")
        end,
    },
    {
        "anuvyklack/hydra.nvim",
        event = "VimEnter",
        keys = { "<leader>" },
        config = function()
            require("keymaps.main")
            require("keymaps.options")
        end,
    },
    {
        "TimUntersberger/neogit",
        event = "VimEnter",
        dependencies = {
            {
                "sindrets/diffview.nvim",
                cmd = {
                    "DiffviewOpen",
                    "DiffviewClose",
                    "DiffviewToggleFiles",
                    "DiffviewFocusFiles",
                },
            },
        },
        config = {
            disable_signs = false,
            disable_context_highlighting = false,
            disable_commit_confirmation = false,
            signs = {
                -- { CLOSED, OPENED }
                section = { ">", "v" },
                item = { ">", "v" },
                hunk = { "", "" },
            },
            integrations = { diffview = true },
            use_magit_keybindings = true,
        },
    },
    {
        "kyazdani42/nvim-tree.lua",
        version = "nightly",
        cmd = "NvimTreeToggle",
        config = true,
    },
    {
        "toppair/peek.nvim",
        ft = "markdown",
        build = "deno task --quiet build:fast",
        config = function()
            local create_cmd = vim.api.nvim_create_user_command

            create_cmd("PeekOpen", require("peek").open, {})
            create_cmd("PeekClose", require("peek").close, {})

            require("peek").setup({
                auto_load = false,
                close_on_bdelete = true,
                syntax = true,
                theme = "dark",
                update_on_change = true,
                throttle_at = 200000,
                throttle_time = "auto",
            })
        end,
    },
    {
        "nvim-telescope/telescope.nvim",
        cmd = "Telescope",
        dependencies = {
            "nvim-telescope/telescope-file-browser.nvim",
            { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
            {
                "nvim-telescope/telescope-frecency.nvim",
                dependencies = { "tami5/sqlite.lua" },
            },
            "nvim-telescope/telescope-project.nvim",
            "nvim-telescope/telescope-ui-select.nvim",
            "MrcJkb/telescope-manix",
            "debugloop/telescope-undo.nvim",
        },
        config = function()
            require("keymaps.toolset.telescope")

            local telescope = require("telescope")
            local ts_prev = require("telescope.previewers")
            local ts_sort = require("telescope.sorters")

            telescope.setup({
                defaults = {
                    prompt_prefix = "   ",
                    selection_caret = " ",
                    vimgrep_arguments = {
                        "rg",
                        "--color=never",
                        "--no-heading",
                        "--with-filename",
                        "--line-number",
                        "--column",
                        "--smart-case",
                    },
                    layout_config = {
                        horizontal = {
                            prompt_position = "bottom",
                            preview_width = 0.55,
                            results_width = 0.8,
                        },
                        vertical = { mirror = false },
                        width = 0.87,
                        height = 0.80,
                        preview_cutoff = 120,
                    },
                    border = {},
                    borderchars = {
                        "─",
                        "│",
                        "─",
                        "│",
                        "╭",
                        "╮",
                        "╯",
                        "╰",
                    },
                    buffer_previewer_maker = ts_prev.buffer_previewer_maker,
                    color_devicons = true,
                    file_ignore_patterns = { "node_modules" },
                    file_previewer = ts_prev.vim_buffer_cat.new,
                    file_sorter = ts_sort.get_fuzzy_file,
                    generic_sorter = ts_sort.get_generic_fuzzy_sorter,
                    grep_previewer = ts_prev.vim_buffer_vimgrep.new,
                    path_display = { shorten = 4 },
                    qflist_previewer = ts_prev.vim_buffer_qflist.new,
                    use_less = true,
                    winblend = 0,
                },
                extensions = {
                    frecency = {
                        show_scores = true,
                        show_unindexed = true,
                        ignore_patterns = { "*.git/*", "*/tmp/*" },
                    },
                    fzf = {
                        fuzzy = true,
                        override_generic_sorter = true,
                        override_file_sorter = true,
                        case_mode = "smart_case",
                    },
                },
            })

            telescope.load_extension("dotfiles")
            telescope.load_extension("file_browser")
            telescope.load_extension("fzf")
            telescope.load_extension("project")
            telescope.load_extension("ui-select")
            telescope.load_extension("manix")
            telescope.load_extension("undo")
        end,
    },
    {
        "akinsho/toggleterm.nvim",
        event = "UIEnter",
        config = function()
            require("keymaps.toolset.toggleterm")

            require("toggleterm").setup({
                auto_scroll = true,
                close_on_exit = true,
                start_in_insert = true,
                direction = "vertical",
                float_opts = {
                    border = "curved", -- 'shadow' = ???
                    winblend = 3,
                },
                size = function(term)
                    if term.direction == "horizontal" then
                        return 15
                    elseif term.direction == "vertical" then
                        return vim.o.columns * 0.4
                    end
                end,
            })
        end,
    },
}