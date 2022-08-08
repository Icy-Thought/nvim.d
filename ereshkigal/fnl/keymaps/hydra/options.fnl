(import-macros {: set!} :macros.option)
(import-macros {: colorscheme} :macros.highlight)

(local Hydra (require :hydra))

(local options-hint "
  ^ ^        Options
  ^
  _e_: %{ve} Virtual Edit
  _i_: %{list} Invisible Characters
  _s_: %{spell} Spelling
  _w_: %{wrap} Word Wrap
  _c_: %{cul} Cursor-line
  _v_: %{cul} Cursor-column
  _n_: %{nu} Number-line
  _r_: %{rnu} Relative Numbers
  _b_: Light/Dark Mode
  ^
       ^^^^              _q_: Quit!
")

(Hydra {:name :Options
        :hint options-hint
        :config {:color :amaranth
                 :invoke_on_body true
                 :hint {:position :middle
                        :border :rounded}}
        :mode [:n :x]
        :body :<leader>o
        :heads [[:b (fn []
                      (if (= vim.o.background :dark)
                          (set! background :light)
                          (set! background :dark))
                      (require :oxocarbon))
                 {:desc "Light- or Dark-mode"}]
                [:n (fn []
                      (if (= vim.o.number true)
                          (set! nonumber)
                          (set! number)))
                    {:desc :number-line}]
                [:r (fn []
                      (if (= vim.o.relativenumber true)
                          (set! norelativenumber)
                          (do
                            (set! number)
                            (set! relativenumber))))
                    {:desc :relative-number}]
                [:e (fn []
                      (if (= vim.o.virtualedit :all)
                          (set! virtualedit :block)
                          (set! virtualedit :all)))
                    {:desc :virtual-edit}]
                [:i (fn []
                      (if (= vim.o.list true)
                          (set! nolist)
                          (set! list)))
                    {:desc "show invisible"}]
                [:s (fn []
                      (if (= vim.o.spell true)
                          (set! nospell)
                          (set! spell)))
                    {:exit true :desc :spelling}]
                [:w (fn []
                      (if (= vim.o.wrap true)
                          (set! nowrap)
                          (set! wrap)))
                    {:desc :wrap}]
                [:c (fn []
                      (if (= vim.o.cursorline true)
                          (set! nocursorline)
                          (set! cursorline)))
                    {:desc "cursor-line"}]
                [:v (fn []
                      (if (= vim.o.cursorcolumn true)
                          (set! nocursorcolumn)
                          (set! cursorcolumn)))
                    {:desc "cursor-column"}]
                [:q nil {:exit true}]]})
