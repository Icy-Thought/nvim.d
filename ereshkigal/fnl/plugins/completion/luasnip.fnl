(local {: config} (require :luasnip))

(local {: choiceNode
        : insertNode} (require :luasnip.util.types))

(local {: lazy_load} (require :luasnip.loaders.from_vscode))

(config.set_config {:enable_autosnippets true
                    :ext_opts {choiceNode {:active {:virt_text [[" " :Keyword]]}}
                               insertNode {:active {:virt_text [["●" :Special]]}}}
                    :history true
                    :delete_check_events :TextChangedI
                    :updateevents "TextChanged,TextChangedI,InsertLeave"})

;; Load vscode-snippets
(lazy_load)

;; Load custom defined snippets
(require :snippets.tex)
(require :snippets.tex-math)
