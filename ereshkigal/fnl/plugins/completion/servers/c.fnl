(import-macros {: lsp-init!} :macros.lsp)
(local lsp (require :lspconfig))

(lsp.clangd.setup {1 lsp-init!
                   :cmd ["clangd"
                         "--background-index"
                         "--suggest-missing-includes"
                         "--clang-tidy"
                         "--header-insertion=iwyu"]})
