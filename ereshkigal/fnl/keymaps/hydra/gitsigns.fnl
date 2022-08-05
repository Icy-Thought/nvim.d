(local Hydra (require :hydra))

;; Only show when git integration == loaded (when in git repo)
(local loader (. (require :packer) :loader))
(local gitrepo (vim.fn.isdirectory :.git/index))

(when gitrepo
  (loader "gitsigns.nvim")
  (local {: toggle_linehl
          : toggle_deleted
          : next_hunk
          : prev_hunk
          : undo_stage_hunk
          : stage_buffer
          : preview_hunk
          : toggle_deleted
          : blame_line
          : show} (require :gitsigns))
  (local git-hint "
                    Git

    _J_: next hunk     _d_: show deleted
    _K_: prev hunk     _u_: undo last stage
    _s_: stage hunk    _/_: show base file
    _p_: preview hunk  _S_: stage buffer
    _b_: blame line    _B_: blame show full
  ^
    _<Enter>_: Neogit         _q_: Exit
  ")

  (Hydra {:name :Git
          :hint git-hint
          :mode [:n :x]
          :body :<leader>g
          :config {:buffer bufnr
                   :color :red
                   :invoke_on_body true
                   :hint {:border :solid :position :middle}
                   :on_key (fn []
                             (vim.wait 50))
                   :on_enter (fn []
                               (vim.cmd.mkview)
                               (vim.cmd "silent! %foldopen!")
                               (toggle_linehl true))
                   :on_exit (fn []
                              (local cursor-pos (vim.api.nvim_win_get_cursor 0))
                              (vim.cmd.loadview)
                              (vim.api.nvim_win_set_cursor 0 cursor-pos)
                              (vim.cmd.normal "zv")
                              (toggle_linehl false)
                              (toggle_deleted false))}
          :heads [[:J (fn []
                        (when vim.wo.diff
                          (lua "return \"]c\""))
                        (vim.schedule (fn []
                                        (next_hunk)))
                        :<Ignore>)
                      {:expr true :desc "next hunk"}]
                  [:K (fn []
                        (when vim.wo.diff
                          (lua "return \"[c\""))
                        (vim.schedule (fn []
                                        (prev_hunk)))
                        :<Ignore>)
                      {:expr true :desc "prev hunk"}]
                  [:s (fn []
                        (local mode (: (. (vim.api.nvim_get_mode) :mode) :sub 1 1))
                        (if (= mode :V)
                            (do
                              (local esc
                                     (vim.api.nvim_replace_termcodes :<Esc> true true true))
                              (vim.api.nvim_feedkeys esc :x false)
                              (vim.cmd "'<,'>Gitsigns stage_hunk"))
                            (vim.cmd.Gitsigns "stage_hunk")))
                      {:desc "stage hunk"}]
                  [:u undo_stage_hunk {:desc "undo last stage"}]
                  [:S stage_buffer {:desc "stage buffer"}]
                  [:p preview_hunk {:desc "preview hunk"}]
                  [:d toggle_deleted {:nowait true :desc "toggle deleted"}]
                  [:b blame_line {:desc :blame}]
                  [:B (fn []
                        blame_line {:full true})
                      {:desc "blame show full"}]
                  ["/" show {:exit true :desc "show base file"}]
                  [:<Enter> (fn []
                              (vim.cmd.Neogit))
                   {:exit true :desc :Neogit}]
                  [:q nil {:exit true :nowait true :desc :exit}]]}))
