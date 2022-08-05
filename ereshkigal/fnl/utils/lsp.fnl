(local {: str?
        : ->str} (require :macros.lib.types))

(local {: update_capabilities} (require :cmp_nvim_lsp))

(var capabilities (vim.lsp.protocol.make_client_capabilities))
(set capabilities (update_capabilities capabilities))

(fn enhance-attach [client bufnr]
  (vim.api.nvim_buf_set_option bufnr :omnifunc "v:lua.vim.lsp.omnifunc")
  (set client.server_capabilities.document_formatting false)
  (set client.server_capabilities.document_range_formatting false))

(λ lsp-init! []
   "Boilerplate for attaching the neccessary bits to our LSP-server(s)"
   (:on-attach enhance-attach)
   (:capabilities capabilities))

(λ load-lspserv [file]
   "Load lsp-server defined within the `completion.server/ directory"
   (let [file (->str file)]
       (require (.. :plugins.completion.servers. file)) nil))

{: lsp-init!
 : load-lspserv}
