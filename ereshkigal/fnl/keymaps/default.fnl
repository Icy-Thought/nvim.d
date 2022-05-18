(import-macros {: g!
	       	: map!} :hibiscus.vim)

; Remap `space` -> leader-key
(g! :mapleader " ")
(g! :maplocalleader " ")

(local opts [:noremap :silent])

; Better window navigation
(map! [n opts] :<C-h> :<C-w>h)
(map! [n opts] :<C-j> :<C-w>j)
(map! [n opts] :<C-k> :<C-w>k)
(map! [n opts] :<C-l> :<C-w>l)

; Resize with arrows
(map! [n opts] :<C-Up> ":resize -2<CR>")
(map! [n opts] :<C-Down> ":resize +2<CR>")
(map! [n opts] :<C-Left> ":vertical resize -2<CR>")
(map! [n opts] :<C-Right> ":vertical resize +2<CR>")

; Navigate buffers
(map! [n opts] :<S-l> ":bnext<CR>")
(map! [n opts] :<S-h> ":bprevious<CR>")

; Move text up & down
(map! [n opts] :<A-j> "<Esc>:m .+1<CR>==gi")
(map! [n opts] :<A-k> "<Esc>:m .-2<CR>==gi")

; Press `jk` quickly to enter
(map! [i opts] :jk :<ESC>)

; Remain in indent mode
(map! [v opts] :< :<gv)
(map! [v opts] :> :>gv)

; Move text up & down
(map! [v opts] :<A-j> ":m .+1<CR>==")
(map! [v opts] :<A-k> ":m .-2<CR>==")
(map! [v opts] :p "\"_dP")

; Move text up & down
(map! [x opts] :J ":move '>+1<CR>gv-gv")
(map! [x opts] :K ":move '<-2<CR>gv-gv")
(map! [x opts] :<A-j> ":move '>+1<CR>gv-gv")
(map! [x opts] :<A-k> ":move '<-2<CR>gv-gv")

; Better terminal navigation
;; (map! [t opts] :<C-h> :<C-\\><C-N><C-w>h)
;; (map! [t opts] :<C-j> :<C-\\><C-N><C-w>j)
;; (map! [t opts] :<C-k> :<C-\\><C-N><C-w>k)
;; (map! [t opts] :<C-l> :<C-\\><C-N><C-w>l)
