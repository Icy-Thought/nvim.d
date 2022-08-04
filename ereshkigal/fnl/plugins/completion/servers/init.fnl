(import-macros {: lsp-init!} :macros.lsp)

(local lspconfig (require :lspconfig))

(let [lsp-noconf [:pyright
                  :clojure_lsp]]
  (each [_ server (ipairs lsp-noconf)]
    ((. (. lspconfig server) :setup) lsp-init!)))

(fn lsp-require [server]
  (if (= (type server) :string)
      (require (.. :plugins.completion.servers. server)) nil))

(let [languages [:c
                 :haskell
                 :latex
                 :lua
                 ;;:rust
                 :python]]
  (each [v (ipairs languages)]
    (lsp-require (. languages v))))
