(import-macros {: map!} :macros.binding)

(local {: setup
        : load_extension} (require :telescope))
(local actions (require :telescope.actions))
(local {:buffers buffers!
        :colorscheme colorscheme!
        :commands commands!
        :file_browser file_browser!
        :find_files find-files!
        :frequency frequency!
        :git_branches checkout-branch!
        :git_commits checkout-commit!
        :git_status git-status!
        :help_tags help-tags!
        :keymaps keymaps!
        :live_grep live-grep!
        :loclist loclist!
        :man_pages man-pages!
        :oldfiles oldfiles!
        :projects projects!
        :quickfix quickfix!} (require :telescope.builtin))

;; Search file by name
(map! [n] "<localleader> " find-files!
          "Find File")
(map! [n] "<localleader>ff" file-browser!
          "Browse Project Files")

;; Open recently used file
(map! [n] "<localleader>fr" frequency!
          "List Frequent Files")
(map! [n] "<localleader>fR" oldfiles!
          "Open Recent File")

;; Search file by content
(map! [n] "<localleader>/" live-grep!
          "Search Project")

;; Switch buffer (list)
(map! [n] "<localleader>bb" buffers!
          "Switch Buffer")

;; Select project to work on
(map! [n] "<localleader>pp" projects!
          "Select Project")

(map! [n] "<localleader>hs" colorscheme!
          "Change Colorscheme")

;; Search help tags
(map! [n] "<localleader>fh" help-tags!
          "Find a help tag")

;; List available commands
(map! [n] "<localleader>hc" commands! 
          "List Available Commands")

;; List available mappings
(map! [n] "<localleader>hk" keymaps!
          "List Available Bindings")

;; Search Man-pages
(map! [n] "<localleader>hm" man-pages!
          "Show Man-Page")

;; Search quickfix list
(map! [n] "<localleader>fq" quickfix!)

;; Search location list
(map! [n] "<localleader>fk" loclist!)

;; Checkout Git branch
(map! [n] "<localleader>bb" checkout-branch!
          "Checkout branch")

;; Checkout at Git commit
(map! [n] "<localleader>gc" checkout-commit!
          "Checkout at Commit")

;; List Git changed files
(map! [n] "<localleader>gs" git-status!
          "List Changes")

;; Configure telescope
(setup {:defaults {:prompt_prefix "   "
                   :selection_caret " "
                   :borderchars ["─" "│" "─" "│" "╭" "╮" "╯" "╰"]
                   :layout_config {:horizontal {:prompt_position "bottom"
                                                :preview_width 0.55
                                                :results_width 0.8}
                                   :vertical {:width 0.87
                                              :height 0.80
                                              :preview_cutoff 120
                                              :mirror false}}
                   :vimgrep_arguments [:rg
                                       :--color=never
                                       :--no-heading
                                       :--with-filename
                                       :--line-number
                                       :--column
                                       :--smart-case]
                   :mappings {:i {"<C-h>" actions.which_key
                                  "<ESC>" actions.close
                                  "<C-q>" actions.smart_send_to_qflist
                                  "<C-k>" actions.smart_send_to_loclist
                                  "<C-Up>" actions.cycle_history_prev
                                  "<C-Down>" actions.cycle_history_next}}}
        :extensions {:fzf {:fuzzy true
                           :override_generic_sorter true
                           :override_file_sorter true
                           :case_mode "smart_case"}
                     :frequency {:show_scores true
                                 :show_unindexed true
                                 :ignore_patterns [:*.git/* :*/tmp/*]})
(load_extension :fzy_native
                :frequency
                :file_browser
                :projects)
