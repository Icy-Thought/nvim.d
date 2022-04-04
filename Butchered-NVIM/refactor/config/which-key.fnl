(import-macros {: map!} :macros.binding)

(local {: setup} (require :which-key))

(setup {:spelling {:enable true}}
        :key_labels {:<space> "SPC"
                     :<cr> "RET"
                     :<tab> "TAB"}
        :window {:border "rounded"
                 :margin [1 0 1 0]
                 :padding [1 1 1 1]}
        :ignore_missing true)
