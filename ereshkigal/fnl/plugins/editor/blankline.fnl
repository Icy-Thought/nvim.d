(local {: setup} (require :indent_blankline))

(setup {:char "│"
        :char_list_blankline ["|" "┊" "┆" "¦"]
        :space_char_blankline " "
        :show_first_indent_level true
        :show_trailing_blankline_indent false
        :filetype_exclude [""
                           :NvimTree
                           :Octo
                           :TelescopePrompt
                           :Trouble
                           :dashboard
                           :git
                           :help
                           :markdown
                           :undotree]
        :buftype_exclude [:terminal :nofile]
        :show_current_context true
        :show_current_context_start true
        :context_patterns [:class
                           :function
                           :method
                           :block
                           :list_literal
                           :selector
                           :^if
                           :^table
                           :if_statement
                           :while
                           :for
                           :type
                           :var
                           :import]})

