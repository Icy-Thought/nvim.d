(import-macros {: set!} :macros.option)
(import-macros {: colorscheme} :macros.highlight)

(local Hydra (require :hydra))

(local options-hint "
  ^ ^        Options
  ^
  _v_ %{ve} virtual edit
  _i_ %{list} invisible characters
  _s_ %{spell} spell
  _w_ %{wrap} wrap
  _c_ %{cul} cursor line
  _n_ %{nu} number
  _r_ %{rnu} relative number
  _b_ Toggle Background
  ^
       ^^^^              _<Esc>_
")

(Hydra {:name :Options
        :hint options-hint
        :config {:color :amaranth
                 :invoke_on_body true
                 :hint {:border :solid :position :middle}}
        :mode [:n :x]
        :body :<leader>o
        :heads [[:b (fn []
                      (if (= vim.o.background :dark)
                          (set! background :light)
                          (set! background :dark))
                      (require :oxocarbon))
                 {:desc :Background}]
                [:n (fn []
                      (if (= vim.o.number true)
                          (set! nonumber)
                          (set! number)))
                    {:desc :number}]
                [:r (fn []
                      (if (= vim.o.relativenumber true)
                          (set! norelativenumber)
                          (do
                            (set! number)
                            (set! relativenumber))))
                    {:desc :relativenumber}]
                [:v (fn []
                      (if (= vim.o.virtualedit :all)
                          (set! virtualedit :block)
                          (set! virtualedit :all)))
                    {:desc :virtualedit}]
                [:i (fn []
                      (if (= vim.o.list true)
                          (set! nolist)
                          (set! list)))
                    {:desc "show invisible"}]
                [:s (fn []
                      (if (= vim.o.spell true)
                          (set! nospell)
                          (set! spell)))
                    {:exit true :desc :spell}]
                [:w (fn []
                      (if (= vim.o.wrap true)
                          (set! nowrap)
                          (set! wrap)))
                    {:desc :wrap}]
                [:c (fn []
                      (if (= vim.o.cursorline true)
                          (set! nocursorline)
                          (set! cursorline)))
                    {:desc "cursor line"}]
                [:<Esc> nil {:exit true}]]})
