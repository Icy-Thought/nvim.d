(require-macros :hibiscus.packer)

; Firstly, setup packer!
(packer-setup)

(packer
    (use! :udayvir-singh/tangerine.nvim)
    (use! :udayvir-singh/hibiscus.nvim
          :requires [:udayvir-singh/tangerine.nvim])

    ;; Colorschemes
    (use! :catppuccin/nvim
	  :module "../themes/catppuccin.fnl")
 
    ;; Aesthetics
    (use! :ChristianChiarulli/dashboard-nvim
          :module "../modules/dashboard.fnl")
    (use! :norcalli/nvim-colorizer.lua
          :config "require('colorizer').setup()")
    (use! :lewis6991/gitsigns.nvim
          :requires [:nvim-lua/plenary.nvim]
          :config "require('gitsigns').setup()")
    (use! :kyazdani42/nvim-web-devicons) ; TODO: check icon status later.
    (use! :nvim-lualine/lualine.nvim
          :requires [:kyazdani42/nvim-web-devicons: :opt true ] ; TODO: check proper way
          :module "../modules/lualine.fnl")
    (use! :akinsho/bufferline.nvim
          :requires [:kyazdani42/nvim-web-devicons]
          :module "../modules/bufferline.fnl")
    (use! :gelguy/wilder.nvim
          :module "../modules/wilder.fnl") ; TODO: add fzy-lua-native + cpsm deps.
    (use! :lukas-reineke/indent-blankline.nvim
          :module "../modules/blankline.fnl")

    ;; Toolset
    (use! :kyazdani42/nvim-tree.lua
          :requires [:kyazdani42/nvim-web-devicons]
          :config "require('nvim-tree').setup()")
    (use! :nvim-telescope/telescope.nvim
          :requires [:nvim-lua/plenary.nvim
                     [:nvim-telescope/telescope-fzf-native.nvim {:run "make"}]
                     :nvim-telescope/telescope-file-browser.nvim
                     :nvim-telescope/telescope-frecency.nvim
                     :vim-telescope/telescope-project.nvim]
          :module "../modules/telescope.fnl")
    (use! :folke/which-key.nvim 
          :module "../modules/which-key.fnl")
    (use! :akinsho/nvim-toggleterm.lua
          :tag :v1.*
          :config "require('toggleterm').setup()")
    (use! :TimUntersberger/neogit
          :config "require('neogit').setup()")
    (use! :pwntester/octo.nvim
          :requires [:nvim-lua/plenary.nvim
                     :nvim-telescope/telescope.nvim
                     :kyazdani42/nvim-web-devicons]
          :config "require('octo').setup()")
    (use! :windwp/nvim-spectre
          :requires [:nvim-lua/plenary.nvim]
          :config "require('spectre').setup()")

    ;; Editor
    (use! :neovim/nvim-lspconfig 
          :module "../modules/lspconfig.fnl")
    (use! :jose-elias-alvarez/null-ls.nvim
          :requires [:nvim-lua/plenary.nvim]
          :module "../modules/null-ls.fnl")
    (use! :folke/trouble.nvim
          :requires [:kyazdani42/nvim-web-devicons]
          :config "require('trouble').setup()")
    (use! :hrsh7th/nvim-cmp
          :requires [:hrsh7th/cmp-nvim-lsp
                     :hrsh7th/cmp-buffer
                     :hrsh7th/cmp-path
                     :hrsh7th/cmp-cmdline
                     :L3MON4D3/LuaSnip
                     :rafamadriz/friendly-snippets
                     :saadparwaiz1/cmp_luasnip]
          :module "../modules/cmp.fnl")
    ;; (use! :github/copilot.vim)
    (use! :nvim-treesitter/nvim-treesitter :run ":TSUpdate"
          :module "../modules/treesitter.fnl")
    (use! :numToStr/Comment.nvim
          :config "require('Comment').setup()")
    (use! :windwp/nvim-autopairs
          :config "require('nvim-autopairs').setup()") ;TODO: use config if default = terrible..
    (use! :folke/todo-comments.nvim
          :requires [:nvim-lua/plenary.nvim]
          :config "require('todo-comments').setup()")
    (use! :iamcco/markdown-preview.nvim 
          :run (fn []
                 (. vim.fn "mkdp#util#install"))
          :module "../modules/md-preview.fnl")
    (use! :lervag/vimtex
          :module "../modules/vimtex.fnl")
    (use! :iurimateus/luasnip-latex-snippets.nvim
          :requires [:L3MON4D3/LuaSnip
                     :lervag/vimtex]
          :ft "tex")

    ;; Miscellaneous
  )