(require-macros :ereshkigal.macros)
;; Place your private configuration here! Remember, you do not need to run 'nyoom
;; sync' after modifying this file!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set 'colorscheme' or manually load a theme through
;; 'require' function. This is the default:
(colorscheme oxocarbon)

;; (Macros) set! => vim.opt options. (Default = true)
;; To disable option -> add `no` before option-name. (t.ex: nonumber)

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
(set! breakindentopt+ ["shift:2" "min:20"])
(set! backspace+ [:indent :eol :start])
(set! clipboard :unnamedplus)
(set! concealcursor :niv)
(set! cursorline)
(set! nocursorcolumn)
(set! magic)
(set! mouse :a)
(set! nowrap)
(set! noshowmode)
(set! shada+ [ "!" "'300" "<50" "@100" "s10" "h"])
(set! shortmess+ [:c :I :s])
(set! signcolumn "yes")
(set! nostartofline)
(set! whichwrap "<>[]hl")
(set! nowrap)

;; Diff & View & View Conf
(set! diffopt+ [:filler
                :iwhite
                :internal
                "algorithm:patience"])

(set! sessionoptions+ [:curdir
                       :help
                       :tabpages
                       :winsize])

(set! viewoptions+ [:folds
                    :cursor
                    :curdir
                    :slash
                    :unix])

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
(set! shiftround)
(set! shiftwidth 4)
(set! softtabstop 4)

;; Indentation rules
(set! copyindent)
(set! preserveindent)
(set! smartindent)

;; Completion & Aesthetics
(set! completeopt+ [:menu :menuone :preview :noinsert])

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
(set! iskeyword+ ["-"])
(set! linebreak)
(set! smartcase)

;; List & their aesthetics
(set! list)
(set! listchars+ {:eol "↴"
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
(set! wildignore+ [:.git
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


;; The let option sets global, or `vim.g` options.
;; Heres an example with localleader, setting it to <space>m
(let! maplocalleader " m")

;; map! is used for mappings
;; Heres an example, preseing esc should also remove search highlights
(map! [n] "<esc>" "<esc><cmd>noh<cr>")

;; Events
;;; More eager auto-read
(augroup! auto-read-on-steroids
          (autocmd! FocusGained * "checktime"))

;;; Auto-change dir on BufEnter
(augroup! follow-buffer-dir
          (autocmd! BufEnter * "silent! lcd %:p:h"))

;;; Restore cursor on exit
(augroup! restore-cursor-on-exit
          (autocmd! VimLeave * '(set! guicursor ["a:ver100-blinkon0"])))

;;; Auto move to the location of the last edit (TODO)
(augroup! last-nvimtree-close
         (autocmd! BufEnter * (fn []
                                (when (and (and (not (: (vim.fn.expand "%:p") :match :.git))
                                                (> (vim.fn.line "'\"") 1))
                                           (<= (vim.fn.line "'\"") (vim.fn.line "$")))
                                  (vim.cmd "normal! g'\"")
                                  (vim.cmd "normal zz")))))

;;; Force write shada on nvim-exit
(augroup! force-write-shada
          (autocmd! VimLeave * (fn []
                                 (if (= (vim.fn.has :nvim-0.7) 1)
                                     (vim.cmd :wshada!)
                                     (vim.cmd :wviminfo!)))))

;;; require custom parinfer plugin on InsertEnter
;; hence why parinfer-rust is added in /opt (we just use it to build the dylib)
(augroup! parinfer
          (autocmd! InsertEnter * '(require :plugins.editor.parinfer)))

;;; Close Nvim-Tree if == last window
(augroup! last-nvimtree-close
         (autocmd! BufEnter * (fn []
                                (when (and (= (vim.fn.winnr "$") 1)
                                           (= (vim.fn.bufname)
                                              (.. :NvimTree_ (vim.fn.tabpagenr))))
                                  (vim.cmd :quit)))))

;;; Equalize window dimensions after resize
(augroup! auto-window-resize
          (autocmd! VimResized * "tabdo wincmd ="))

;;; Limit char-width = 80 chars
(augroup! character-width-limit
          (autocmd! FileType "markdown,norg" '(if (not vim.g.neovide)
                                                  (set! textwidth 80)
                                                  (set! textwidth 120))))
