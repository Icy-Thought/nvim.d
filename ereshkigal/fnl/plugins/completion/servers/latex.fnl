(local {: lsp-init!} :utils.lsp)
(local lsp (require :lspconfig))

(lsp.texlab.setup {1 lsp-init!
                   :log_level vim.lsp.protocol.MessageType.Log
                   :settings {:texlab {:auxDirectory :build
                                       :build {:executable :tectonic
                                               :args ["-X"
                                                      "compile"
                                                      "%f"
                                                      "--synctex"]}
                                       :forwardSearch {:executable :sioyek
                                                       :args ["--reuse-instance"
                                                              "--forward-search-file '%b'"
                                                              "--forward-search-line %n"
                                                              "--inverse-search"
                                                              "'nvim --headless -es --cmd %l:%f'"]}
                                       :chktex {:onEdit false
                                                :onOpenAndSave true}
                                       :diagnosticsDelay 100
                                       :formatterLineLength 80
                                       :latexFormatter :texlab}}})
