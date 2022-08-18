(local Hydra (require :hydra))

(local rust-hint "
                  Rust
  _r_: Runnables      _m_: Expand Macro
  _d_: Debugabbles    _c_: Open Cargo
  _s_: Rustssr        _p_: Parent Module
  _h_: Hover Actions  _w_: Reload Workspace
  _D_: Open Docs      _g_: View (Create) Graph
^
  _i_: Toggle Inlay Hints     _q_: Quit!
")

(Hydra {:name :Rust
        :hint rust-hint
        :config {:color :red
                 :invoke_on_body true
                 :hint {:position :middle
                        :border :rounded}}
        :mode :n
        :body :<Leader>r
        :heads [[:r (fn []
                      (vim.cmd.RustRunnables))
                    {:exit true}]
                [:d (fn []
                      (vim.cmd.RustDebuggables))
                    {:exit true}]
                [:s (fn []
                      (vim.cmd.RustSSR))
                    {:exit true}]
                [:h (fn []
                      (vim.cmd.RustHoverActions))
                    {:exit true}]
                [:D (fn []
                      (vim.cmd.RustOpenExternalDocs))
                    {:exit true}]
                [:m (fn []
                      (vim.cmd.RustExpandMacro))
                    {:exit true}]
                [:c (fn []
                      (vim.cmd.RustOpenCargo))
                    {:exit true}]
                [:p (fn []
                      (vim.cmd.RustParentModule))
                    {:exit true}]
                [:w (fn []
                      (vim.cmd.RustReloadWorkspace))
                    {:exit true}]
                [:g (fn []
                      (vim.cmd.RustViewCrateGraph))
                    {:exit true}]
                [:i (fn []
                      (vim.cmd.RustToggleInlayHints))]
                [:q nil {:exit true :nowait true}]]})
