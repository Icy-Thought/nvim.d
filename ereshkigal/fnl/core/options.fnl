(import-macros {: set!} :macros.option)

;; add Mason to path
(set vim.env.PATH (.. vim.env.PATH ":" (vim.fn.stdpath :data) :/mason/bin))

;; Faster refresh-rate + Gitsigns
(set! updatetime 200)
(set! timeoutlen 500)
(set! ttimeoutlen 0)
(set! redrawtime 1500)

;; General UI-Conf
(set! cmdheight 1)
(set! conceallevel 0)
(set! helpheight 12)
(set! laststatus 2)
(set! pumheight 15)
(set! showtabline 2)

(set! termguicolors)
(set! background :dark)

;; Options -> Maintain sanity
(set! breakat "\\ \\\t;:,!?")
(set! backspace [:indent :eol :start])
(set! clipboard :unnamedplus)
(set! concealcursor :niv)
(set! cursorline)
(set! nocursorcolumn)
(set! magic)
(set! mouse :a)
(set! nowrap)
(set! noshowmode)
(set! shada [ "!" "'300" "<50" "@100" "s10" "h"])
(set! shortmess {:c true
                 :I true
                 :s true })
(set! signcolumn "yes")
(set! nostartofline)
(set! whichwrap "<>[]hl")
(set! nowrap)

;; Diff & View & View Conf
(set! diffopt [:filler
               :iwhite
               :internal
               "algorithm:patience"])

(set! sessionoptions [:curdir
                      :help
                      :tabpages
                      :winsize])

(set! viewoptions [:folds
                   :cursor
                   :curdir
                   :slash
                   :unix ])

;; File-Encoding
(set! encoding :UTF-8)
(set! fileencoding "UTF-8")

;; File(s) status & Swap
(set! autoread)
(set! undofile)
(set! noswapfile)
(set! nowritebackup)

;; A decent number-line
(set! number)
(set! numberwidth 4)
(set! relativenumber)

;; A good-enough scroll
(set! scrolloff 8)
(set! sidescrolloff 8)

;; Maintainging a healthier <tab>
(set! expandtab)
(set! showtabline 2)
(set! shiftround)
(set! shiftwidth 4)
(set! softtabstop 4)

;; Indentation rules
(set! copyindent)
(set! preserveindent)
(set! smartindent)

;; Completion & Aesthetics
(set! completeopt [:menu :menuone :preview :noinsert])

;; How folds shall be treated
(set! foldcolumn "1")
(set! foldenable)
(set! foldlevel 99)
(set! foldlevelstart 99)

;; Search + Word Params
(set! gdefault)
(set! grepformat "%f:%l:%c:%m")
(set! grepprg "rg --hidden --vimgrep --smart-case --")
(set! hidden)
(set! hlsearch)
(set! ignorecase)
(set! inccommand :nosplit)
(set! incsearch)
(set! infercase)
(set! iskeyword ["-"])
(set! linebreak)
(set! smartcase)

;; List & their aesthetics
(set! list)
(set! listchars {:eol "↴"
                 :extends "→"
                 :nbsp "+"
                 :precedes "←"
                 :space "⋅"
                 :tab "»·"
                 :trail "•"})

;; Specify desired split-location
(set! splitright)
(set! splitbelow)

;; Wildcard exansions
(set! wildignore [:.git
                  :.hg
                  :.svn
                  :*.pyc
                  :*.o
                  :*.out
                  :*.jpg
                  :*.jpeg
                  :*.png
                  :*.gif
                  :*.zip
                  :**/tmp/**
                  :*.DS_Store
                  :**/node_modules/**
                  :**/bower_modules/**])
