(import-macros {: map! : g!} :hibiscus.vim)

; Remap `space` -> leader-key
(g! :mapleader " ")
(g! :maplocalleader " ")

; Check how to apply (later)
(local opts {:noremap true :silent true})

; Better window navigation
(map! [n] :<C-h> :<C-w>h opts)
(map! [n] :<C-j> :<C-w>j opts)
(map! [n] :<C-k> :<C-w>k opts)
(map! [n] :<C-l> :<C-w>l opts)

; Resize with arrows
(map! [n] :<C-Up> ":resize -2<CR>")
(map! [n] :<C-Down> ":resize +2<CR>")
(map! [n] :<C-Left> ":vertical resize -2<CR>")
(map! [n] :<C-Right> ":vertical resize +2<CR>")

; Navigate buffers
(map! [n] :<S-l> ":bnext<CR>")
(map! [n] :<S-h> ":bprevious<CR>")

; Move text up & down
(map! [n] :<A-j> "<Esc>:m .+1<CR>==gi")
(map! [n] :<A-k> "<Esc>:m .-2<CR>==gi")

; Press `jk` quickly to enter
(map! [i] :jk :<ESC>)

; Remain in indent mode
(map! [v] :< :<gv)
(map! [v] :> :>gv)

; Move text up & down
(map! [v] :<A-j> ":m .+1<CR>==")
(map! [v] :<A-k> ":m .-2<CR>==")
(map! [v] :p '"_dP')

; Move text up & down
(map! [x] :J ":move '>+1<CR>gv-gv")
(map! [x] :K ":move '<-2<CR>gv-gv")
(map! [x] :<A-j> ":move '>+1<CR>gv-gv")
(map! [x] :<A-k> ":move '<-2<CR>gv-gv")

; Better terminal navigation
;; (map! [t] :<C-h> :<C-\\><C-N><C-w>h)
;; (map! [t] :<C-j> :<C-\\><C-N><C-w>j)
;; (map! [t] :<C-k> :<C-\\><C-N><C-w>k)
;; (map! [t] :<C-l> :<C-\\><C-N><C-w>l)
