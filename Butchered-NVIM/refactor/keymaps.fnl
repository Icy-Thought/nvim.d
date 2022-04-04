(import-macros {: map!} :macros.binding)

(local {: getbufinfo
        : getbufvar} vim.fn)
(local {:cmd cmd!} vim)
(local {: format} string)

(fn wildmenumode? [...] (= (vim.fn.wildmenumode ...) 1))
(fn empty? [xs] (= 0 (length xs)))

;;; /====================/
;;; / Available Modes    /
;;; /====================/
;;; / Normal = "n"       /
;;; / Insert = "i"       /
;;; / Visual = "v"       /
;;; / Visual Block = "x" /
;;; / Terminal = "t"     /
;;; / Command_mode = "c" /
;;; /====================/

;;; /================/
;;; / Basic Mappings /
;;; /================/
(map! [n] "<localleader>fs" "<cmd>w!<cr>"
          "Save File")
(map! [n] "<localleader>bd" "<cmd>bd!<cr>"
          "Close Buffer")
(map! [n] "<localleader>bO" "<cmd>%bd|e#<cr>"
          "Close Buffers Except Current")
(map! [n] "<localleader>qq" "<cmd>q!<cr>"
          "Quit Nvim Without Saving")

;;; /===============/
;;; / Miscellaneous /
;;; /===============/
;; Disable highlight on escape
(map! [n] "<esc>" "<esc><cmd>noh<cr>")

;;; /=================/
;;; / Quickfix window /
;;; /=================/
;; Open or focus the quickfix window
(map! [n] "<localleader>q" "<cmd>copen<cr>"
          "open or focus the quickfix window")

;; Close the quickfix window
(map! [n] "<localleader>Q" "<cmd>cclose<cr>"
          "close the quickfix list window")

;;; /=====================/
;;; / Filesystem Explorer /
;;; /=====================/
(map! [n] "<C-n>"
      ;; This mapping checks if there are buffers with the filesystem explorer filetype
      ;; If there are, every buffer is closed
      ;; If there are not any, a new one is opened using <cmd>Lexplore<cr>
      (let [carbon-buffers (icollect [_ {: bufnr} (ipairs (getbufinfo))]
                                     (let [filetype (getbufvar bufnr "&filetype")]
                                       (if (= :carbon filetype) bufnr)))]
        (if (empty? carbon-buffers) (cmd! "Lexplore")
          (each [_ bufnr (ipairs carbon-buffers)]
            (cmd! (format "bdelete! %s" bufnr))))))

;;; /===================/
;;; / Wildmenu Settings /
;;; /===================/
;; Close the wildmenu
(map! [c :expr] "<space>" (if (wildmenumode?) "<C-y>" "<space>"))

;;; /==================/
;;; / Movement Control /
;;; /==================/
;; Move to the beginning
(map! [nvo] "<C-h>" "^")
(map! [nvo] "<C-left>" "^")
(map! [i] "<C-h>" "<C-o>^")
(map! [i] "<C-left>" "<C-o>^")
(map! [c] "<C-h>" "<home>")
(map! [c] "<C-left>" "<home>")

;; Move to the end
(map! [nvo] "<C-l>" "$")
(map! [nvo] "<C-right>" "$")
(map! [i] "<C-l>" "<C-o>$")
(map! [i] "<C-right>" "<C-o>$")
(map! [c] "<C-l>" "<end>")
(map! [c] "<C-right>" "<end>")

;;; /=========================/
;;; / Window & Buffer Control /
;;; /=========================/
;; Window navigation
(map! [n] "<C-h>" "<C-w>h")
(map! [n] "<C-j>" "<C-w>j")
(map! [n] "<C-k>" "<C-w>k")
(map! [n] "<C-l>" "<C-w>l")

;; Buffer navigation
(map! [n] "<S-l>" ":bnext<cr>")
(map! [n] "<S-h>" ":bprevious<cr>")

;; Arrow-key window resize
(map! [n] "<C-Up>" ":resize -2<cr>")
(map! [n] "<C-Down>" ":resize +2<cr>")
(map! [n] "<C-Left>" ":vertical resize -2<cr>")
(map! [n] "<C-Right>" ":vertical resize +2<cr>")

;;; /========================/
;;; / Text objects + Control /
;;; /========================/
;; Line object
(map! [xo :silent] "il" ":<C-u>normal! g_v^<cr>"
          "Inner Line")
(map! [xo :silent] "al" ":<C-u>normal! $v0<cr>"
          "Around Line")

;; Document object
(map! [x :silent] "id" ":<C-u>normal! G$Vgg0<cr>"
          "Inner Document")
(map! [o :silent] "id" ":<C-u>normal! GVgg<cr>"
          "Inner Document")

;; Text movement control
; Move text up and down
(map! [nvo] "<A-j>" "<esc>:m .+1<cr>==gi")
(map! [nvo] "<A-k>" "<esc>:m .-2<cr>==gi")

;;; /=====================/
;;; / Terminal Navigation /
;;; /=====================/
(map! [t] "<C-h>" "<C-\\><C-N><C-w>h")
(map! [t] "<C-j>" "<C-\\><C-N><C-w>j")
(map! [t] "<C-k>" "<C-\\><C-N><C-w>k")
(map! [t] "<C-l>" "<C-\\><C-N><C-w>l")
