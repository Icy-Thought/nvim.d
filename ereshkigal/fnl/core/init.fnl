(require-macros :macros.event)
(import-macros {: set!} :macros.option)
(import-macros {: colorscheme} :macros.highlight)

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
   ;; :python :python3
   (let [providers [:perl :node :ruby]]
     (each [_ v (ipairs providers)]
       (let [provider (.. :loaded_ v :_provider)]
         (tset vim.g provider 0)))))

(λ packer-ready? []
   (let [compiled? (= (vim.fn.filereadable
                        (.. (vim.fn.stdpath :config)
                            :/lua/packer_compiled.lua)) 1)
                   load-compiled #(require :packer_compiled)]
     (if compiled?
         (load-compiled)
         (. (require :packer) :sync))))

(λ is-neovide? []
   (if vim.g.neovide
       (do
         (set! guifont "VictorMono Nerd Font:h9:sb")

         ;; lua settings == not recognized by neovide???
         (let [config ["neovide_no_idle = v:true"
                       "neovide_cursor_antialiasing = v:true"
                       "neovide_cursor_trail_length = 0.05"
                       "neovide_cursor_animation_length = 0.03"
                       "neovide_cursor_vfx_mode = 'sonicboom'"
                       "neovide_cursor_vfx_opacity = 200.0"
                       "neovide_cursor_vfx_particle_density = 5.0"
                       "neovide_cursor_vfx_particle_lifetime = 1.2"
                       "neovide_cursor_vfx_particle_speed = 20.0"]]
           (each [_ v (ipairs config)]
             (vim.cmd (.. "let g:" v)))))))

(λ initialize-core []
   (disable-builtins!)
   (disable-providers!)

   (packer-ready?)
   (require :core.packer)

   ;; require remaining core
   (require :core.options)
   (require :core.events)
   (require :keymaps.basics)

   ;; Neovide settings (when installed)
   (is-neovide?)

   ;; Apply desired colorscheme
   (colorscheme catppuccin))

(initialize-core)
