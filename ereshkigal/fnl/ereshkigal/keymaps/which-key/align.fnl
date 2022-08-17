(import-macros {: map!} :macros.keybind)

(local ALG (require :align))

(map! [x] :aa (fn []
                ((. ALG align_to_char) 1 true))
      {:noremap true :silent true :desc "Align to 1 Char"})

(map! [x] :as (fn []
                ((. ALG align_to_char) 2 true true))
      {:noremap true :silent true :desc "Align to 2 Chars"})

(map! [x] :aw (fn []
                ((. ALG align_to_string) false true true))
      {:noremap true :silent true :desc "Align to String"})

(map! [x] :ar (fn []
                ((. ALG align_to_string) true true true))
      {:noremap true :silent true :desc "Align acc. lua pattern"})

(map! [x] :gaw
      (fn []
        (ALG.operator ALG.align_to_string
                      {:is_pattern false :reverse true :preview true}))
      {:noremap true :silent true :desc "Align paragraph to Str"})

(map! [x] :gaa
      (fn []
        (ALG.operator ALG.align_to_char {:reverse true}))
      {:noremap true :silent true :desc "Align paragraph to 1 Char"})
