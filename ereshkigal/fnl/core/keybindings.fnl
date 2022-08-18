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

(map! [n] "<leader>:" "<cmd>Telescope commands<CR>")


;; -------===[ Hotpot ]===-------
;; Evaluate highlighted block with `<Visual>hr`
(local reflect-session {:id nil :mode :compile})
(fn new-or-attach-reflect []
  (let [reflect (require :hotpot.api.reflect)
                with-session-id
                (if reflect-session.id
                    (fn [f]
                      ;; session id already exists, so we can just pass
                      ;; it to whatever needs it
                      (f reflect-session.id))

                    (fn [f]
                      ;; session id does not exist, so we need to create an
                      ;; output buffer first then we can pass the session id on,
                      ;; and finally hook up the output buffer to a window
                      (let [buf (vim.api.nvim_create_buf true true)
                                id (reflect.attach-output buf)]
                        (set reflect-session.id id)
                        (f id)
                        ;; create window, which will forcibly assume focus, swap the buffer
                        ;; to our output buffer and setup an autocommand to drop the session id
                        ;; when the session window is closed.
                        (vim.schedule
                          #(do
                             (vim.api.nvim_command "botright vnew")
                             (vim.api.nvim_win_set_buf (vim.api.nvim_get_current_win) buf)
                             (vim.api.nvim_create_autocmd :BufWipeout {:buffer buf
                                                                       :once true
                                                                       :callback #(set reflect-session.id nil)}))))))]

    ;; we want to set the session mode to our current mode, and attach the
    ;; input buffer once we have a session id
    (with-session-id
      (fn [session-id]
        ;; we manually set the mode each time so it is persisted if we close the session.
        ;; By default `reflect` will use compile mode.
        (reflect.set-mode session-id reflect-session.mode)
        (reflect.attach-input session-id 0)))))

(vim.keymap.set :v :hr new-or-attach-reflect)

(fn swap-reflect-mode []
  (let [reflect (require :hotpot.api.reflect)]
    ;; only makes sense to do this when we have a session active
    (when reflect-session.id
      ;; swap held mode
      (if (= reflect-session.mode :compile)
          (set reflect-session.mode :eval)
          (set reflect-session.mode :compile))
      ;; tell session to use new mode
      (reflect.set-mode reflect-session.id reflect-session.mode))))

(vim.keymap.set :n :hx swap-reflect-mode)
