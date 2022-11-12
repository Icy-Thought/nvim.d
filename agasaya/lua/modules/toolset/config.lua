local config = {}

function config.codewindow()
    require("codewindow").setup()
end

function config.hydra_nvim()
    require("keymaps.main")
    require("keymaps.options")
end

function config.gitsigns()
    require("gitsigns").setup()
    require("keymaps.editor.gitsigns")
end

function config.nvim_tree()
    require("nvim-tree").setup()
end

function config.neogit()
    local neogit = require("neogit")
    neogit.setup({
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
    })
end

function config.telescope()
    local telescope = require("telescope")
    local ts_prev = require("telescope.previewers")
    local ts_sort = require("telescope.sorters")

    require("keymaps.toolset.telescope")

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
end

function config.toggleterm()
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
end

return config
