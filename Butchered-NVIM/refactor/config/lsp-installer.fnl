(local lsp-installer (require :nvim-lsp-installer))
(local servers [:bashls :hls :rnix :pyright :rust_analyzer])

(each [_ name (pairs servers)]
  (local (server-is-found server) (lsp-installer.get_server name))
  (when (and server-is-found (not (server:is_installed)))
    (print (.. "Installing " name))
    (server:install)))	
