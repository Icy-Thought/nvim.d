(local {: branch
        : check
        : cmdline_pipeline
        : history
        : lua_fzy_filter
        : lua_fzy_highlighter
        : make_hl
        : pcre2_highlighter
        : popupmenu_border_theme
        : popupmenu_buffer_flags
        : popupmenu_devicons
        : popupmenu_empty_message_with_spinner
        : popupmenu_renderer
        : popupmenu_scrollbar
        : python_file_finder_pipeline
        : python_fuzzy_pattern
        : python_search_pipeline
        : renderer_mux
        : set_option
        : setup
        : substitute_pipeline
        : wildmenu_index
        : wildmenu_renderer
        : wildmenu_spinner} (require :wilder))

(setup {:modes [":" "/" "?"]})

(set_option :pipeline
            [(branch
               (python_file_finder_pipeline
                 {:file_command (fn [ctx arg]
                                  (if (not= (string.find arg ".") nil)
                                      [:rg "--files" "--hidden"]
                                    [:rg "--files"]))
                  :dir_command (fn [ctx arg]
                                 (if (not= (string.find arg ".") nil)
                                     [:fd "-td" "-H"]
                                   [:fd "-td"]))
                  :filters [:fuzzy_filter :difflib_sorter]})

               (substitute_pipeline
                 {:pipeline (python_search_pipeline
                              {:skip_cmdtype_check 1
                               :pattern (python_fuzzy_pattern {:start_at_boundary 0})})})
               (cmdline_pipeline  {:fuzzy 2
                                   :fuzzy_filter (lua_fzy_filter)})
               [(check (fn [ctx x]
                           (= x "")))
                (history)]
               (python_search_pipeline
                 {:pattern (python_fuzzy_pattern
                             {:start_at_boundary 0})}))])

(local highlighters [(pcre2_highlighter)
                     (lua_fzy_highlighter)])

(local popupmenu-renderer
       (popupmenu_renderer
         (popupmenu_border_theme {:highlights {:default :Normal
                                               :border :NormalFloat
                                               :accent (make_hl :WilderAccent
                                                                :Normal
                                                                :TabLineSel)}
                                  :border :rounded
                                  :empty_message (popupmenu_empty_message_with_spinner)
                                  :highlighter highlighters
                                  :left [" "
                                         (popupmenu_devicons)
                                         (popupmenu_buffer_flags
                                           {:flags " a + "
                                            :icons {:+ ""
                                            :a ""
                                            :h ""}})]
                                  :right [" " (popupmenu_scrollbar)]})))

(let [wildmenu-renderer
       (wildmenu_renderer {:highlighter highlighters
                           :separator " · "
                           :left [" " (wildmenu_spinner) " "]
                           :right [" " (wildmenu_index)]})]
       (set_option :renderer
                   (renderer_mux {":" popupmenu-renderer
                                  :/ wildmenu-renderer
                                  :substitute wildmenu-renderer})))
