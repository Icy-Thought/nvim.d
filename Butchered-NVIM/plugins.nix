{ config, optionalString, ... }:
let
  themesDir = config.snowflake.themesDir;
  acs = config.modules.themes.active;
in ''
  (import-macros {: pack
                  : pack! : unpack!} :macros.pack)

  (local lisp-ft [:fennel
                  :clojure
                  :lisp
                  :racket
                  :scheme])

  ;; Essential Dependencies:
  (pack! "wbthomason/packer.nvim")
  (pack! "rktjmp/hotpot.nvim")
  (pack! "Olical/conjure")

  ;; Aesthetic Dependencies:
  ${optionalString (acs != null)
  (builtins.readFile "${themesDir}/${acs}/config/nvim/pack.fnl")}

  (pack! "akinsho/bufferline.nvim" {:req "bufferline"
                                    :requires ["kyazdani42/nvim-web-devicons"]})
  (pack! "glepnir/dashboard-nvim" {:req "dashboard"})
  (pack! "j-hui/fidget.nvim" {:init "fidget"})
  (pack! "nvim-lualine/lualine.nvim" {:req "lualine"})
  (pack! "folke/which-key.nvim" {:req "which-key"})
  (pack! "gelguy/wilder.nvim" {:run ":UpdateRemotePlugins"
                               :req "wilder-nvim"})

  ;; Editor Dependencies:
  (pack! "numToStr/Comment.nvim" {:req "comment-nvim"})
  (pack! "narutoxy/dim.lua" {:init "dim"
                             :requires ["nvim-treesitter/nvim-treesitter"
                                        "neovim/nvim-lspconfig"]})
  (pack! "lewis6991/gitsigns.nvim" {:req "gitsigns"
                                    :requires ["nvim-lua/plenary.nvim"]})
  (pack! "lukas-reineke/indent-blankline.nvim" {:req "indent-blankline"})
  (pack! "folke/lsp-colors.nvim" {:init "lsp-colors"})
  (pack! "windwp/nvim-autopairs" {:req "autopairs"})
  (pack! "norcalli/nvim-colorizer.lua" {:req "colorizer"})
  (pack! "kevinhwang91/nvim-hlslens" {:req "hlslens"})

  (pack! "nvim-treesitter/nvim-treesitter" {:run ":TSUpdate"
                                            :req "treesitter"
                                            :requires ["p00f/nvim-ts-rainbow"
                                                       "nvim-treesitter/nvim-treesitter-refactor"
                                                       "nvim-treesitter/nvim-treesitter-textobjects"
                                                       "JoosepAlviste/nvim-ts-context-commentstring"]})
  (pack! "nacro90/numb.nvim" {:init "numb"})
  (pack! "kyazdani42/nvim-web-devicons" {:req "devicons"})
  (pack! "eraserhd/parinfer-rust" {:run "cargo build --release"
                                   :ft lisp-ft})
  (pack! "sQVe/sort.nvim" {:init "sort"})
  (pack! "folke/todo-comments.nvim" {:init "todo-comments"
                                     :requires ["nvim-lua/plenary.nvim"]})

  ;; Toolset Expansion:
  (pack! "github/copilot.vim" {:req "copilot-vim"})
  ;; (pack! "glacambre/firenvim" {:run #(vim.fn.firenvim#install 0)})
  (pack! "kevinhwang91/nvim-bqf")
  (pack! "TimUntersberger/neogit" {:req "neogit"})
  (pack! "iamcco/markdown-preview.nvim" {:run "cd app && npm install"
                                         :req "markdown-preview"
                                         :ft "markdown"})
  (pack! "jghauser/mkdir.nvim" {:config #(require "mkdir")})
  (pack! "kyazdani42/nvim-tree.lua" {:req "nvim-tree"
                                     :requires ["kyazdani42/nvim-web-devicons"]})
  (pack! "pwntester/octo.nvim" {:init "octo"
                                :req "octo-nvim"
                                :requires ["nvim-lua/plenary.nvim"
                                           "nvim-telescope/telescope.nvim"
                                           "kyazdani42/nvim-web-devicons"]})
  (pack! "nvim-telescope/telescope.nvim" {:req "telescope"
                                          :requires ["nvim-lua/popup.nvim"
                                                     "nvim-lua/plenary.nvim"
                                                     "nvim-telescope/telescope-file-browser.nvim"
                                                     "nvim-telescope/telescope-frecency.nvim"
                                                     "nvim-telescope/telescope-fzy-native.nvim"]})
  (pack! "ahmedkhalf/project.nvim" {:init "project_nvim"})
  (pack! "akinsho/toggleterm.nvim" {:req "toggleterm"})

  ;; Completion Dependencies:
  (pack! "hrsh7th/nvim-cmp" {:req "cmp"
                             :requires ["hrsh7th/cmp-cmdline"
                                        "hrsh7th/cmp-buffer"
                                        "hrsh7th/cmp-nvim-lsp"
                                        "hrsh7th/cmp-path"
                                        "saadparwaiz1/cmp_luasnip"
                                        "lukas-reineke/cmp-under-comparator"]})
  (pack! "L3MON4D3/LuaSnip" {:requires ["rafamadriz/friendly-snippets"]})
  (pack! "abecodes/tabout.nvim" {:req "tabout"
                                 :wants "nvim-treesitter"
                                 :after "nvim-cmp"})

  ;; Language Server Protocol (LSP):
  (pack! "neovim/nvim-lspconfig")
  (pack! "b0o/schemastore.nvim")
  (pack! "nvim-lua/lsp_extensions.nvim")
  (pack! "ray-x/lsp_signature.nvim")
  (pack! "jose-elias-alvarez/null-ls.nvim" {:req "null-ls"
                                            :requires ["nvim-lua/plenary.nvim"
                                                       "neovim/nvim-lspconfig"]})

  ;; Language-specific Dependencies:
  (pack! "bakpakin/fennel.vim")

  (unpack!)
''
