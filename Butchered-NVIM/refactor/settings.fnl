(import-macros {: set!} :hibiscus.vim)


;; edit
;;Environment Configurations:
(let! python3_host_prog (expand "/etc/profiles/per-user/icy-thought/bin/python3")
      loaded_ruby_provider 0
      loaded_perl_provider 0)

;; Editor Configurations:
; Filetype detection:
(let! do_filetype_lua 1)

; File configuration:
(set! nowritebackup
      noswapfile
      expandtab)

; Control <tab>:
(set! numberwidth 4
      softtabstop 4
      shiftwidth 4 
      showtabline 2)

; Line wrapping:
(set! linebreak
      breakindent
      breakindentopt ["shift:2"]
      smartindent 
      showbreak "↳ ")

; Formatting:
(set! formatoptions [:q :j])

; Spell-checking:
(set! nospell)
(set! spelllang [:en])
(set! spelloptions [:camel])

; Undo Persistence:
(set! undodir (.. configuration-folder "/undodir.nvim")
      undofile)

; CursorHold delay
(set! updatetime 300)

;; Terminal
(set! mouse :a)

;; UI-related
(set! cmdheight 2
      cursorline 
      noshowmode
      number
      relativenumber
      scrolloff 8
      sidescrolloff 8
      termguicolors)

;; Define character symbols
(set! list 
      listchars {:trail "·"
                 :tab "→ "
                 :nbsp "·"})

;; Sign Column
(set! signcolumn "auto:1-9")

;; Fold configuration
; Everything unfolded by default
(set! foldlevelstart 99)
; Fold format
(set! fillchars "fold: " 
      foldtext #(vim.fn.printf "   %-6d%s"
                               (- vim.v.foldend (+ vim.v.foldstart 1))
                               (vim.fn.getline vim.v.foldstart)))

;;; /==========================/
;;; / Completion Configuration /
;;; /==========================/
;; Insert-mode completion
(set! infercase
      pumheight 10
      shortmess+ :c)

;; Command-mode completion
(set! wildcharm (byte (escape "<tab>")) 
      wildignorecase)

;;; /============================/
;;; / Command-mode configuration /
;;; /============================/
(set! ignorecase
      smartcase
      gdefault)

;;; /=====================/
;;; / NETRW Configuration /
;;; /=====================/
(let! netrw_banner 0
      netrw_liststyle 3
      netrw_browse_split 4
      netrw_altv 1
      netrw_winsize 20
      netrw_list_hide "\\(^\\|\\s\\s\\)\\zs\\.\\S\\+")

;;; /=============================/
;;; / Miscellaneous Configuration /
;;; /=============================/
(set! clipboard "unnamedplus"
      diffopt [:filler :internal :indent-heuristic :algorithm:histogram]
      lazyredraw
      timeoutlen 500)

;; LocalLeader
(let! maplocalleader (escape "<space>"))
