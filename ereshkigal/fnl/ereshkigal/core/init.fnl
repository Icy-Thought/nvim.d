(λ disable-builtins! []
   (let [built-ins [:2html_plugin
                    :getscript
                    :getscriptPlugin
                    :gtags
                    :gzip
                    :logiPat
                    :matchit
                    :matchparen
                    :netrw
                    :netrwFileHandlers
                    :netrwPlugin
                    :netrwSettings
                    :rrhelper
                    :spellfile_plugin
                    :tar
                    :tarPlugin
                    :vimball
                    :vimballPlugin
                    :zip
                    :zipPlugin]]
     (each [_ v (ipairs built-ins)]
       (let [plugin (.. :loaded_ v)]
         (tset vim.g plugin 1)))))

(λ disable-providers! []
   (let [providers [:perl :node :ruby :python :python3]]
     (each [_ v (ipairs providers)]
       (let [provider (.. :loaded_ v :_provider)]
         (tset vim.g provider 0)))))

(λ load-packer []
   (if (= (vim.fn.filereadable (.. (vim.fn.stdpath :config) "/lua/packer_compiled.lua")) 1)
       (require :packer_compiled)))

(λ initialize-core []
   (disable-builtins!)
   (disable-providers!)
   (load-packer)

   ;; Require core-files
   (require :core.commands)

   ;; Neovide settings (when installed)
   (init-neovide)

   ;; Mason to path -> no need to load mason during startup!
   (set vim.env.PATH 
	(.. vim.env.PATH ":" (vim.fn.stdpath :data) :/mason/bin))

   (require :user.config))

(initialize-core)
