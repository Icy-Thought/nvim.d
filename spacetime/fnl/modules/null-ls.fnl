(import-macros {: augroup!} :hibiscus.vim)

(local null-ls (require :null-ls))

(local formatting null-ls.builtins.formatting)
(local diagnostics null-ls.builtins.diagnostics)
(local code-actions null-ls.builtins.code_actions)

;; TODO: WTF?
(local augroup (augroup! :LspFormatting))

(null-ls.setup {:debounce 150
                :sources [formatting.alejandra
                          formatting.stylua
                          (formatting.prettier.with {:extra_args ["--no-semi"
                                                                  "--single-quote"
                                                                  "--jsx-single-quote"]})
                          (formatting.black.with {:extra_args ["--fast"]
                                                  :filetypes ["python"]})
                          (formatting.isort.with {:extra_args ["--profile" "black"]
                                                  :filetypes ["python"]})
                          (diagnostics.ansiblelint.with {:condition (fn [utils]
                                                                        (and (utils.root_has_file :roles)
                                                                             (utils.root_has_file :inventories)))})
                          diagnostics.shellcheck
                          (diagnostics.markdownlint.with {:filetypes ["markdown"]
                                                          :command "markdownlint-cli2})
                          (diagnostics.vale.with {:filetypes ["markdown"]})
                          (diagnostics.revive.with {:condition (fn [utils]
                                                                    (utils.root_has_file :revive.toml))})
                          code-actions.shellcheck}
                ;; rewrite later
                :on_attach (fn [client bufnr]
                             (when (client.supports_method :textDocument/formatting)
                               (vim.api.nvim_clear_autocmds {:group augroup
                                                             :buffer bufnr})
                               (vim.api.nvim_create_autocmd :BufWritePre
                                                            {:group augroup
                                                             :buffer bufnr
                                                             :callback (fn []
                                                                         (vim.lsp.buf.formatting_sync))})))})
