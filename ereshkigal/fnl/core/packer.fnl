(require-macros :macros.package)

;; Setup packer
(let [packer (require :packer)]
  (packer.init {:git {:clone_timeout 300}
                :profile {:enable true}
                :compile_path (.. (vim.fn.stdpath :config)
                                  :/lua/packer_compiled.lua)
                ;; :snapshot (.. (vim.fn.stdpath :config) :/packer.lock)
                ;; :snapshot_path (vim.fn.stdpath :config)
                :display {:header_lines 2
                          :title " packer.nvim"
                          :working_sym "ﲊ"
                          :error_sym "✗"
                          :done_sym "﫟"
                          :removed_sym ""
                          :moved_sym ""
                          :open_fn (λ open_fn []
                                     (local {: float} (require :packer.util))
                                     (float {:border :rounded}))}}))

;; Defining several local's for ease-of-use:
(local lisp-ft [:fennel :clojure :lisp :racket :scheme])

(local treesitter-cmds [:TSInstall
                        :TSBufEnable
                        :TSBufDisable
                        :TSEnable
                        :TSDisable
                        :TSModuleInfo])

(local mason-cmds [:Mason
                   :MasonInstall
                   :MasonInstallAll
                   :MasonUninstall
                   :MasonUninstallAll
                   :MasonLog])

;; ----------===[ Core-Deps ]===----------
(use-package! :wbthomason/packer.nvim)

(use-package! :nvim-lua/plenary.nvim
              {:module :plenary})

;; ----------===[ Lisp-Conf ]===----------
(use-package! :rktjmp/hotpot.nvim
              {:branch :nightly})

(use-package! :eraserhd/parinfer-rust
              {:opt true
               :run "cargo build --release"})

(use-package! :Olical/conjure
              {:branch :develop
               :ft lisp-ft
               :config (tset vim.g "conjure#extract#tree_sitter#enabled" true)})

;; ----------===[ Aesthetics ]===----------
(use-package! :kyazdani42/nvim-web-devicons
              {:module :nvim-web-devicons})

;; (use-package! :shaunsingh/oxocarbon.nvim
;;               {:run :./install.sh})

(use-package! :catppuccin/nvim
              {:as :catppuccin
               :run :CatppuccinCompile
               :config (load-theme catppuccin)})

;; (use-package! :themercorp/themer.lua {:config (load-theme themer)})

(use-package! :akinsho/bufferline.nvim
              {:config (load-file ui.bufferline)
               :setup (fn []
                        ((. (require :utils.lazy-load) :load-on-file-open!)
                         :bufferline.nvim))})

(use-package! :feline-nvim/feline.nvim
              {:event :VimEnter
               :config (load-file ui.feline)})

(use-package! :glepnir/dashboard-nvim
              {:event :BufWinEnter
               :config (load-file ui.dashboard)})

(use-package! :gelguy/wilder.nvim
              {:run :UpdateRemotePlugins
               :event :CmdlineEnter
               :requires [(pack :romgrk/fzy-lua-native)]
               :config (load-file ui.wilder)})

;; ----------===[ Toolbox ]===----------
(use-package! :nvim-lua/telescope.nvim
              {:cmd :Telescope
               :config [(load-file toolbox.telescope)]
               :requires [(pack :nvim-telescope/telescope-file-browser.nvim
                                {:module :telescope._extensions.file_browser})
                          (pack :nvim-telescope/telescope-frecency.nvim
                                {:module :telescope._extensions.frecency
                                 :requires :tami5/sqlite.lua})
                          (pack :nvim-telescope/telescope-fzf-native.nvim
                                {:module :telescope._extensions.fzf :run :make})
                          (pack :nvim-telescope/telescope-project.nvim
                                {:module :telescope._extensions.project})
                          (pack :nvim-telescope/telescope-ui-select.nvim
                                {:module :telescope._extensions.ui-select})]})

(use-package! :kyazdani42/nvim-tree.lua
              {:tag :nightly
               :cmd :NvimTreeToggle
               :config (call-setup nvim-tree)})

;; (use-package! :folke/which-key.nvim
;;               {:event :VimEnter
;;                :config [(load-file toolbox.which-key)
;;                (load-keymap which-key)]})

(use-package! :anuvyklack/hydra.nvim
              {:keys :<space>
               :config (load-keymap hydra)})

(use-package! :akinsho/nvim-toggleterm.lua
              {:config (call-setup toggleterm)})

(use-package! :TimUntersberger/neogit
              {:cmd :Neogit
               :event :VimEnter
               :config (call-setup neogit)})

(use-package! :lewis6991/gitsigns.nvim
              {:ft :gitcommit
               :config (call-setup gitsigns)
               :setup (fn []
                        ((. (require :utils.lazy-load) :load-gitsigns)))})

;; ----------===[ Editor ]===----------
(use-package! :Vonr/align.nvim
              {:after :nvim-cmp
               :setup (fn []
                        ((. (require :utils.lazy-load) :load-on-file-open!)
                         :align.nvim))})

(use-package! :numToStr/Comment.nvim
              {:config (call-setup Comment)
               :setup (fn []
                        ((. (require :utils.lazy-load) :load-on-file-open!)
                         :Comment.nvim))})

(use-package! :windwp/nvim-autopairs
              {:config (load-file editor.autopairs)
               :setup (fn []
                        ((. (require :utils.lazy-load) :load-on-file-open!)
                         :nvim-autopairs))})

(use-package! :lukas-reineke/indent-blankline.nvim
              {:after :nvim-treesitter
               :config (load-file editor.blankline)
               :setup (fn []
                        ((. (require :utils.lazy-load) :load-on-file-open!)
                         :indent-blankline.nvim))})

(use-package! :ggandor/leap.nvim
              {:config (fn []
                         ((. (require :leap) :set_default_keymaps)))
               :setup (fn []
                        ((. (require :utils.lazy-load) :load-on-file-open!)
                         :leap.nvim))})

(use-package! :nvim-treesitter/nvim-treesitter
              {:run ":TSUpdate"
               :cmd treesitter_cmds
               :module :nvim-treesitter
               :config (load-file editor.treesitter)
               :setup (fn []
                        ((. (require :utils.lazy-load) :load-on-file-open!)
                         :nvim-treesitter))
               :requires [(pack :nvim-treesitter/playground
                                {:cmd :TSPlayground})
                          (pack :nvim-treesitter/nvim-treesitter-textobjects
                                {:after :nvim-treesitter})]})

(use-package! :monkoose/matchparen.nvim
              {:opt true
               :config (call-setup matchparen)
               :setup (fn []
                        ((. (require :utils.lazy-load) :load-on-file-open!)
                         :matchparen.nvim))})

(use-package! :nvim-neorg/neorg
              {:ft :norg
               :after :nvim-treesitter
               :config (load-file editor.neorg)})

(use-package! :norcalli/nvim-colorizer.lua
              {:opt true
               :config (call-setup colorizer)
               :setup (fn []
                        ((. (require :utils.lazy-load) :load-on-file-open!)
                         :nvim-colorizer.lua))})

(use-package! :kevinhwang91/nvim-ufo
              {:requires [(pack :kevinhwang91/promise-async)]
               :config (load-file editor.folding)
               :setup (fn []
                        ((. (require :utils.lazy-load) :load-on-file-open!)
                         :nvim-ufo))})

(use-package! :Pocco81/TrueZen.nvim
              {:cmd :TZAtaraxis
               :config (call-setup true-zen)})

(use-package! :iamcco/markdown-preview.nvim
              {:run (fn []
                      ((. vim.fn "mkdp#util#install")))
               :ft :markdown
               :config [(load-file editor.md-preview)]})

;; ----------===[ Language Server Protocol (LSP) ]===----------
(use-package! "https://git.sr.ht/~whynothugo/lsp_lines.nvim"
              {:after :nvim-lspconfig
               :config (call-setup lsp_lines)})

(use-package! :neovim/nvim-lspconfig
              {:opt true
               :setup (fn []
                        ((. (require :utils.lazy-load) :load-on-file-open!)
                         :nvim-lspconfig))
               :config (load-file completion.lspconfig)})

(use-package! :williamboman/mason.nvim
              {:cmd mason-cmds
               :config (load-file completion.mason)})

(use-package! :j-hui/fidget.nvim
              {:after :nvim-lspconfig
               :config (call-setup fidget)})

(use-package! :hrsh7th/nvim-cmp
              {:config (load-file completion.cmp)
               :wants :LuaSnip
               :event :InsertEnter
               :requires [(pack :hrsh7th/cmp-path {:after :nvim-cmp})
                          (pack :hrsh7th/cmp-buffer {:after :nvim-cmp})
                          (pack :hrsh7th/cmp-nvim-lsp {:after :nvim-cmp})
                          (pack :PaterJason/cmp-conjure {:after :conjure})
                          (pack :saadparwaiz1/cmp_luasnip {:after :nvim-cmp})
                          (pack :lukas-reineke/cmp-under-comparator
                                {:module :cmp-under-comparator})
                          (pack :L3MON4D3/LuaSnip
                                {:event :InsertEnter
                                 :wants :friendly-snippets
                                 :config (load-file completion.luasnip)
                                 :requires [(pack :Icy-Thought/friendly-snippets)]})]})

(use-package! :glepnir/lspsaga.nvim
              {:branch :main
               :after :nvim-lspconfig
               :config [(load-file completion.lspsaga)]})

(use-package! :mhartington/formatter.nvim
              {:config (load-file completion.formatter)
               :setup (fn []
                        ((. (require :utils.lazy-load) :load-on-file-open!)
                         :formatter.nvim))})

;; (use-package! :zbirenbaum/copilot.lua {:after :nvim-cmp
;;                                        :requires [(pack :zbirenbaum/copilot-cmp)]
;;                                        :config (call-setup copilot)})

;; ----------===[ LSP-Lang Specific Conf ]===----------
(use-package! :saecki/crates.nvim
              {:event ["BufRead Cargo.toml"]
               :config (call-setup crates)})

(use-package! :simrat39/rust-tools.nvim
              {:ft :rust
               :branch :modularize_and_inlay_rewrite
               :config (call-setup rust-tools)})

;; (use-package! :simrat39/flutter-tools.nvim
;;               {:ft :dart
;;                :config (call-setup flutter-tools)})

(unpack!)
