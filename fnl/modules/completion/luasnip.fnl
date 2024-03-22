(local {:config {: set_config}} (require :luasnip))

(local {: choiceNode
        : insertNode} (require :luasnip.util.types))

(set_config {:enable_autosnippets true
             :ext_opts {choiceNode {:active {:virt_text [[" " :Keyword]]}}
                        insertNode {:active {:virt_text [["●" :Special]]}}}
             :history true
             :delete_check_events :TextChangedI
             :updateevents "TextChanged,TextChangedI,InsertLeave"})

;; Load vscode-snippets
((. (require :luasnip.loaders.from_vscode) :lazy_load))

;; Load custom defined snippets
(local snippet-dir :modules.completion.my-snippets.)

(require (.. snippet-dir :tex))
(require (.. snippet-dir :tex-math))
