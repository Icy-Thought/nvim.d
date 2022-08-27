(local {: setup : load_extension} (require :telescope))

(setup {:defaults {:prompt_prefix "   "
                   :selection_caret "   "
                   :vimgrep-arguments [:rg
                                       :--color=never
                                       :--no-heading
                                       :--with-filename
                                       :--line-number
                                       :--column
                                       :--smart-case]
                   :entry_prefix "  "
                   :sorting_strategy :ascending
                   :layout_strategy :flex
                   :layout_config {:horizontal {:prompt_position :bottom
                                                :preview_width 0.55}
                                   :vertical {:mirror false}
                                   :width 0.87
                                   :height 0.8
                                   :preview_cutoff 120}
                   :path_display {:shorten 4}
                   :set_env {:COLORTERM :truecolor}
                   :dynamic_preview_title true}
        :extensions {:project {:base_dirs ["~/.config/nvim"]}
                     :frecency {:show_scores true
                                :show_unindexed true
                                :ignore_patterns [:ignore_patterns
                                                  [:*.git/* :*/tmp/*]]}}})

(load_extension :dotfiles)
(load_extension :fzf)
(load_extension :file_browser)
(load_extension :project)
(load_extension :ui-select)

