(local {: lsp-init!} :utils.lsp)
(local lsp (require :lspconfig))

(lsp.rust_analyzer.setup {1 lsp-init!
                         :settings {:rust-analyzer {:assist {:importGranularity :module
                                                             :importPrefix :self}
                                                    :cargo {:loadOutDirsFromCheck true}
                                                    :procMacro {:enable true}}}})
