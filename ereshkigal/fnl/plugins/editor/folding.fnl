(local {: setup} (require :ufo))

(setup {:provider_selector (fn [bufnr filetype buftype]
                                 [:treesitter :indent])})
