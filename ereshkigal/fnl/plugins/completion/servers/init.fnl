(local {: lsp-init!} :utils.lsp)

(local lsp (require :lspconfig))

(let [lsp-noconf [:pyright
                  :clojure_lsp]]
  (each [_ server (pairs lsp-noconf)]
    ((. (. lsp server) :setup) lsp-init!)))

(fn lsp-require [server]
  (if (= (type server) :string)
      (require (.. :plugins.completion.servers. server)) nil))

(let [languages [:c
                 :haskell
                 :latex
                 :lua
                 ;;:rust
                 :python]]
  (each [v (pairs languages)]
    (lsp-require (. languages v))))
