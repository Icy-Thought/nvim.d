(require-macros :macros.event)

;; disable some built-in Neovim plugins and unneeded providers
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
                 :zipPlugin]
      providers [:perl :node :ruby :python :python3]]
  (each [_ v (ipairs built-ins)]
    (let [plugin (.. :loaded_ v)]
      (tset vim.g plugin 1)))
  (each [_ v (ipairs providers)]
    (let [provider (.. :loaded_ v :_provider)]
      (tset vim.g provider 0))))

;; make sure packer is all ready to go
(let [compiled? (= (vim.fn.filereadable (.. (vim.fn.stdpath :config) "/lua/packer_compiled.lua")) 1)
      load-compiled #(require :packer_compiled)]
 (if compiled?
     (load-compiled)
     (. (require :packer) :sync)))

;; Initalize packer
(require :core.packer)

;; colorscheme
(import-macros {: colorscheme} :macros.highlight)
(colorscheme catppuccin)
;; (colorscheme oxocarbon)

;; Load remaining core-modules
(require :core.options)
(require :core.events)
(require :keymaps.basics)
(require :core.neovide)
