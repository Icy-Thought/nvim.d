(import-macros {: map!} :macros.keybind)
(import-macros {: let!} :macros.variable)

;; set leader key
(let! mapleader " ")
(let! maplocalleader " m")

;; ----===[ Modes ]===----
;;  -> Normal_Mode       = [n]
;;  -> Insert_Mode       = [i]
;;  -> Visual_Mode       = [v]
;;  -> Visual_Block_Mode = [x]
;;  -> Terminal_Mode     = [t]
;;  -> Command_Mode      = [c]

;; Disable highlight on escape
(map! [n] :<Esc> :<esc><CMD>noh<CR>)

;; Easier command-line mode
(map! [n] ";" ":")

;; -------===[ Normal Mode ]===-------
(map! [n] :<C-s> :<CMD>write<CR> {:noremap true})

;; Better window navigation
(map! [n] :<C-h> :<C-w>h {:noremap true :silent true})
(map! [n] :<C-j> :<C-w>j {:noremap true :silent true})
(map! [n] :<C-k> :<C-w>k {:noremap true :silent true})
(map! [n] :<C-l> :<C-w>l {:noremap true :silent true})

;; Resize with arrows
(map! [n] :<C-Up> "<CMD>resize -2<CR>" {:noremap true :silent true})
(map! [n] :<C-Down> "<CMD>resize +2<CR>" {:noremap true :silent true})
(map! [n] :<C-Left> "<CMD>vertical resize -2<CR>" {:noremap true :silent true})
(map! [n] :<C-Right> "<CMD>vertical resize +2<CR>" {:noremap true :silent true})

;; Navigate buffers
(map! [n] :<S-l> :<CMD>bnext<CR> {:noremap true :silent true})
(map! [n] :<S-h> :<CMD>bprevious<CR> {:noremap true :silent true})

;; Move text up and down
(map! [n] :<A-j> "<Esc>:m .+1<CR>==gi" {:noremap true :silent true})
(map! [n] :<A-k> "<Esc>:m .-2<CR>==gi" {:noremap true :silent true})

;; -------===[ Insert Mode ]===-------
;; Press jk fast to enter
(map! [i] :jk :<ESC> {:noremap true :silent true})

;; -------===[ Visual Mode ]===-------
;; Stay in indent mode
(map! [v] "<" :<gv {:noremap true :silent true})
(map! [v] "|>" :>gv {:noremap true :silent true})

;; Move text up and down
(map! [v] :<A-j> ":m .+1<CR>==" {:noremap true :silent true})
(map! [v] :<A-k> ":m .-2<CR>==" {:noremap true :silent true})

;; -------===[ Visual-Block Mode ]===-------
;; Move text up and down
(map! [x] :J ":move '>+1<CR>gv-gv" {:noremap true :silent true})
(map! [x] :K ":move '<-2<CR>gv-gv" {:noremap true :silent true})
(map! [x] :<A-j> ":move '>+1<CR>gv-gv" {:noremap true :silent true})
(map! [x] :<A-k> ":move '<-2<CR>gv-gv" {:noremap true :silent true})

;; -------===[ Terminal Mode ]===-------
;; Better terminal navigation
(map! [t] :<C-h> "<C-\\><C-N><C-w>h" {:silent true})
(map! [t] :<C-j> "<C-\\><C-N><C-w>j" {:silent true})
(map! [t] :<C-k> "<C-\\><C-N><C-w>k" {:silent true})
(map! [t] :<C-l> "<C-\\><C-N><C-w>l" {:silent true})

