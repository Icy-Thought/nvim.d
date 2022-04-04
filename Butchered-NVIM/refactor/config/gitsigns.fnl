(import-macros {: map!} :macros.binding)

(local {: setup} (require :gitsigns))

(fn on-attach [bufnr]
  (local {:stage_buffer stage-buffer!
          :undo_stage_hunk undo-stage-hunk!
          :reset_buffer reset-buffer!
          :preview_hunk preview-hunk!
          :blame_line blame-line!
          :toggle_current_line_blame toggle-current-line-blame!
          :diffthis diff!
          :toggle_deleted toggle-deleted!} package.loaded.gitsigns)

  ;; Navigation
  (map! [n :expr] "]c" (if (vim.opt.diff:get) "]c" "<cmd>Gitsigns next_hunk<cr>"))
  (map! [n :expr] "[c" (if (vim.opt.diff:get) "[c" "<cmd>Gitsigns prev_hunk<cr>"))

  ;; Actions
  (map! [nv] "<localleader>hs" "<cmd>Gitsigns stage_hunk<cr>")
  (map! [nv] "<localleader>hr" "<cmd>Gitsigns reset_hunk<cr>")
  (map! [n] "<localleader>hS" stage-buffer!)
  (map! [n] "<localleader>hu" undo-stage-hunk!)
  (map! [n] "<localleader>hR" reset-buffer!)
  (map! [n] "<localleader>hp" preview-hunk!)
  (map! [n] "<localleader>hb" (blame-line! {:full true}))
  (map! [n] "<localleader>tb" toggle-current-line-blame!)
  (map! [n] "<localleader>hd" diff!)
  (map! [n] "<localleader>hD" (diff! "~"))
  (map! [n] "<localleader>td" toggle-deleted!)

  ;; Text object
  (map! [ox] "ih" ":<C-U>Gitsigns select_hunk<cr>"))

(setup {:on_attach on-attach})
