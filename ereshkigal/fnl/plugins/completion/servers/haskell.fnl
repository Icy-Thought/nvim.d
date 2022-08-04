(import-macros {: lsp-init!} :macros.lsp)
(local lsp (require :lspconfig))

(lsp.hls.setup {1 lsp-init!
                :cmd ["haskell-language-server-wrapper"
                      "--lsp"]})
