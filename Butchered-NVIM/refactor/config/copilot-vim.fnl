(import-macros {: let!} :macros.variable)

;; Have copilot play nice with nvim-cmp.
(let! copilot_no_tab_map true
      copilot_assume_mapped true
      copilot_tab_fallback ""
      copilot_filetypes {:* false
                         :python true
                         :rust true
                         :html true
                         :javascript true})
