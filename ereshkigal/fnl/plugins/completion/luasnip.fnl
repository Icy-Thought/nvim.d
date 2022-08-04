(local {: config} (require :luasnip))
(local types (require :luasnip.util.types))
(local {: lazy_load} (require :luasnip.loaders.from_vscode))

(config.set_config {:enable_autosnippets true
                    :ext_opts {types.choiceNode {:active {:virt_text [[" " :Keyword]]}}
                               types.insertNode {:active {:virt_text [["●" :Special]]}}}
                    :history true
                    :delete_check_events :TextChangedI
                    :updateevents "TextChanged,TextChangedI,InsertLeave"})

;; Load snippets
(local {: str?
        : ->str} (require :macros.lib.types))

(λ load-snippet [file]
  "Import custom-defined snippets found in the `nvim/snippet` directory.
   Valid arguements:
     - snippet-file -> a symbol
   Example of use:
   ```fennel
   (load-snippet tex-math)
   ```"
  (assert-compile (sym? file) "expected symbol for snippet-file" file)
  (let [file (->str file)]
    (require (.. (.. (vim.fn.stdpath :config) "/snippets") ,file))))

(lazy_load)

(load-snippet :tex)
(load-snippet :tex-math)
