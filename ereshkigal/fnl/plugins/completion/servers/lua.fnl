(import-macros {: lsp-init!} :macros.lsp)
(local lsp (require :lspconfig))

(lsp.sumneko_lua.setup {1 lsp-init!
                        :settings {:Lua {:diagnostics {:globals [:vim]}
                                         :workspace {:library {(vim.api.nvim_get_runtime_file) true}
                                                     :maxPreload 100000
                                                     :preloadFileSize 10000}
                                         :telemetry {:enable false}}}})
