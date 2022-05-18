(require-macros :hibiscus.vim)

;; General
(set! :autoread true)
(set! :backup false)
(set! :lazyredraw true)
(set! :spell false)
(set! :swapfile false)
(set! :timeoutlen 100)
(set! :undofile true)
(set! :updatetime 300)
(set! :wrap false)
(set! :writebackup false)
(set+ :fileencoding :utf-8)
(set+ :mouse "a")

; commands
;; (command! "set whichwrap+=<,>,[,],h,l")
;; (command! "set iskeyword+=-")

;; Aesthetics
(set! :cmdheight 2)
(set! :conceallevel 1)
(set! :cursorline true)
(set! :number true)
(set! :numberwidth 4)
(set! :pumheight 10)
(set! :relativenumber true)
(set! :showmode false)
(set! :termguicolors true)

;; Editor
(set! :expandtab true)
(set! :scrolloff 8)
(set! :shiftwidth 4)
(set! :showtabline 2)
(set! :sidescrolloff 8)
(set! :smartindent true)
(set! :softtabstop 4)
(set! :splitbelow true)
(set! :splitright true)
(set+ :clipboard "unnamedplus")
(set+ :signcolumn "yes")
(set^ :completeopt ["menuone" "noselect"])

;;(set^ "shortmess:append" {:c true))
;;(set! :diffopt:append({ "internal", "algorithm:patience" })

;; Search
(set! :gdefault true)
(set! :hlsearch true)
(set! :ignorecase true)
(set! :magic true)
(set! :smartcase true)

;; Limit MD char(length) = 80
(augroup! :Markdown 
  [[BufEnter] * "set fo-=c fo-=r fo-=o"]
  [[BufRead BufNewFile] *.md "setlocal textwidth=80 fo+=t"])
