(import-macross {: buf-map!} :macros.binding)

(local {: setup} (require :toggleterm))

(setup {:size (fn [term]
                (if (= term.direction :horizontal) 15
                    (= term.direction :vertical) (* vim.o.columns
                                                    0.4)))
        :open_mapping "<c-\\>"
        :hide_numbers true
        :shade_filetypes {}
        :shade_terminals false
        :shading_factor "1"
        :start_in_insert true
        :insert_mappings true
        :terminal_mappings true
        :persist_size true
        :direction "tab"
        :close_on_exit true
        :shell vim.o.shell
        :float_opts {:border "curved"
                     :winblend 3
                     :highlights {:border "Normal"
                                  :background "Normal"}}})
(fn _G.set_terminal_keymaps []
  (let [opts {:noremap true}]
    (buf-map! 0 :t :<esc> "<C-\\><C-n>" opts)
    (buf-map! 0 :t :jk "<C-\\><C-n>" opts)
    (buf-map! 0 :t :<C-h> "<C-\\><C-n><C-W>h" opts)
    (buf-map! 0 :t :<C-j> "<C-\\><C-n><C-W>j" opts)
    (buf-map! 0 :t :<C-k> "<C-\\><C-n><C-W>k" opts)
    (buf-map! 0 :t :<C-l> "<C-\\><C-n><C-W>l" opts)))

;; if you only want these mappings for toggle term use term://*toggleterm#* instead
(vim.cmd "autocmd! TermOpen term://* lua set_terminal_keymaps()")

;; Use fn's at which-key/init
(local Terminal (. (require :toggleterm.terminal) :Terminal))

(local python (Terminal:new {:cmd "python" :hidden true}))
(set-forcibly! _PYTHON_TOGGLE (fn []
                                (python:toggle)))	

;; Bindings for a variety of terminals to launch from
(map! [n] "<localleader>tp" "<cmd>lua _PYTHON_TOGGLE()<cr>"
          "Python REPL")
(map! [n] "<localleader>tf" "<cmd>ToggleTerm direction=float<cr>"
          "Floating Terminal")
(map! [n] "<localleader>th" "<cmd>ToggleTerm size=10 direction=horizontal<cr>"
          "Horizontal Terminal")
(map! [n] "<localleader>tt" "<cmd>ToggleTerm direction=tab<cr>"
          "Tabbed Terminal")
(map! [n] "<localleader>tv" "<cmd>ToggleTerm size=80 direction=vertical<cr>"
          "Vertical Terminal")
