(local lspconfig (require :lspconfig))
(local lsputil (require :lspconfig.util))

;;; Diagnostics configuration
(let [{: config
       : severity} vim.diagnostic
      {: sign_define} vim.fn]

  (config {:underline {:severity {:min severity.INFO}}
           :float {:style :minimal
                   :border :rounded
                   :source :always}
           :severity_sort true
           :signs {:severity {:min severity.INFO}}
           :underline true
           :virtual_text false ;; handled by lsp_lines
           :update_in_insert true})

  (sign_define :DiagnosticSignError
               {:text "" :texthl :DiagnosticSignError})
  (sign_define :DiagnosticSignWarn
               {:text "" :texthl :DiagnosticSignWarn})
  (sign_define :DiagnosticSignInfo
               {:text "" :texthl :DiagnosticSignInfo})
  (sign_define :DiagnosticSignHint
               {:text "" :texthl :DiagnosticSignHint}))

;;; Minor UI-improvements
(let [{: with : handlers} vim.lsp]
  (set vim.lsp.handlers.textDocument/signatureHelp
       (with handlers.signature_help
             {:border :rounded}))
  (set vim.lsp.handlers.textDocument/hover
       (with handlers.hover
             {:border :rounded})))

(λ on-attach [client bufnr]
  (vim.api.nvim_buf_set_option bufnr :omnifunc "v:lua.vim.lsp.omnifunc")
  (set client.server_capabilities.document_formatting false)
  (set client.server_capabilities.document_range_formatting false))

(local {: update_capabilities} (require :cmp_nvim_lsp))
(local capabilities (update_capabilities
                      (vim.lsp.protocol.make_client_capabilities)))

(λ reload_lsp []
  (vim.lsp.stop_client (vim.lsp.get_active_clients))
  (vim.cmd :edit))

(λ open_lsp_log []
  (let [path (vim.lsp.get_log_path)]
    (vim.cmd (.. "edit " path))))

(vim.cmd "command! -nargs=0 LspLog call v:lua.open_lsp_log()")
(vim.cmd "command! -nargs=0 LspRestart call v:lua.reload_lsp()")

;; (Init) Language-server with pre-defined configurations
;; https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
(local server-noconf [:clojure_lsp
                      :pyright])

;; (Init) Language-servers with our custom conf
(local join lsputil.path.join)
(local file? lsputil.path.is_file)
(local dir? lsputil.path.is_dir)

(λ parent-that-matches [fun]
  #(lsputil.search_ancestors $ fun))

(local known-lua-root-paths
  {:/usr/share/awesome/lib true})

(λ lua-root-path? [path]
  (or (. known-lua-root-paths path)
      (dir? (join path ".git"))
      (dir? (join path "spec"))
      (file? (join path ".luarc.json"))
      (file? (join path ".luacov"))
      (file? (join path ".luacheckrc"))
      (file? (join path ".stylua.toml"))))

(λ full-path-to-current-file []
  (vim.fn.fnamemodify (vim.fn.expand "%") ":p"))

(local lang-settings
       {:clangd {:cmd ["clangd"
                       "--background-index"
                       "--suggest-missing-includes"
                       "--clang-tidy"
                       "--header-insertion=iwyu"]}

        :hls {:cmd ["haskell-language-server-wrapper"
                    "--lsp"]}

        :sumneko_lua {:root_dir (parent-that-matches lua-root-path?)
                      :settings {:Lua {:completion {:callSnippet "Replace"}
                                       :telemetry {:enable false}
                                       :diagnostics {:disable ["ambiguity-1"]}}}}

        :rust_analyzer {:settings {:rust-analyzer {:assist {:importGranularity :module
                                                            :importPrefix :self}
                                                   :cargo {:loadOutDirsFromCheck true}
                                                   :procMacro {:enable true}}}}

        :texlab {:log_level vim.lsp.protocol.MessageType.Log
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
                                     :latexFormatter :texlab}}}})

;; Default lsp-setup for our beloved language-servers
(each [_ server (ipairs server-noconf)]
  ((. lspconfig server :setup)
   (doto (or (. lang-settings server)
             {})
     (tset :capabilities capabilities)
     (tset :on_attach on-attach)
     (tset :flags {:debounce_text_changes 150}))))
