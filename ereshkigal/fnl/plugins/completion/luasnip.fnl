(local {: config} (require :luasnip))
(local {: lazy_load} (require :luasnip.loaders.from_vscode))

(local {: str? 
        : ->str} (require :macros.lib.types))

(λ load-snippet [snippet]
  "Import custom-defined snippets found in the `nvim/snippet` directory.
  Valid arguements:
    - snippet-file -> a symbol
  Example of use:
  ```fennel
  (load-snippet tex-math)
  ```"
  (assert-compile (sym? snippet) "expected symbol for snippet-file" snippet)
  (let [snippet (->str snippet)]
    `#(require (.. (.. (vim.fn.stdpath :config) "/snippets") ,snippet))))

(config.set_config {:enable_autosnippets true
                    :history true 
                    :delete_check_events :TextChangedI
                    :updateevents "TextChanged,TextChangedI,InsertLeave"})

;; Load snippets
(lazy_load)

(load-snippet tex)
(load-snippet tex-math)
