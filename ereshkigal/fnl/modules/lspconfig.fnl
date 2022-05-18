(import-macros {: map!} :hibiscus.vim)

(local signs [{:name :DiagnosticSignError :text ""}
              {:name :DiagnosticSignWarn :text ""}
              {:name :DiagnosticSignHint :text ""}
              {:name :DiagnosticSignInfo :text ""}])

(each [_ sign (ipairs signs)]
    (vim.fn.sign_define sign.name 
        {:texthl sign.name 
         :text sign.text 
         :numhl ""}))

(vim.diagnostic.config {:virtual_text false
                        :signs {"active" signs}
                        :update_in_insert true
                        :underline true
                        :severity_sort true
                        :float {:focusable false
                                :style :minimal
                                :border :rounded
                                :source :always
                                :header ""
                                :prefix ""}})

;; Override border style globally (Rounded)
(local orig-util-open-floating-preview vim.lsp.util.open_floating_preview)

(fn vim.lsp.util.open_floating_preview [contents syntax opts ...]
  (set-forcibly! opts (or opts {}))
  (set opts.border (or opts.border :rounded))
  (orig-util-open-floating-preview contents syntax opts ...))

;; See `:help vim.diagnostic.*` for documentation
(local opts [:noremap :silent :buffer])

(map! [n opts] :<C-e> 'vim.diagnostic.open_float)
(map! [n opts] "[d" 'vim.diagnostic.goto_prev)
(map! [n opts] "]d" 'vim.diagnostic.goto_next)
(map! [n opts] :<C-l> 'vim.diagnostic.setloclist)

;; Use an on_attach function to only map the following keys
;; after the language server attaches to the current buffer
(fn on-attach [client bufnr]
    ;; See `:help vim.lsp.*` for documentation on any of the below functions
    (map! [n opts] :gD 'vim.lsp.buf.declaration)
    (map! [n opts] :gd 'vim.lsp.buf.definition)
    (map! [n opts] :K 'vim.lsp.buf.hover)
    (map! [n opts] :gi 'vim.lsp.buf.implementation)
    (map! [n opts] :<C-k> 'vim.lsp.buf.signature_help)
    (map! [n opts] :<C-d> 'vim.lsp.buf.type_definition)
    (map! [n opts] :<C-b> 'vim.lsp.buf.code_action)
    (map! [n opts] :gr 'vim.lsp.buf.references)

    ;;  Allow null-ls to handle formatting
    (client.resolved_capabilities.document_formatting false)
    (client.resolved_capabilities.document_range_formatting false))

;; Add additional capabilities supported by nvim-cmp
(local cmp-nvim-lsp (require :cmp_nvim_lsp))

(var capabilities (vim.lsp.protocol.make_client_capabilities))
(set capabilities (cmp-nvim-lsp.update_capabilities capabilities))

(local lspconfig (require :lspconfig))

;; Language Server Protocols
;; https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
(lspconfig.hls.setup {:on_attach on-attach
                      :capabilities capabilities
                      :cmd ["haskell-language-server-wrapper" "--lsp"]
                      :settings [:haskell {:formattingProvider "stylish-haskell"}]})

(lspconfig.rnix.setup {:on_attach on-attach 
                       :capabilities capabilities})
