(local Hydra (require :hydra))

(local rust-hint "
                  Rust
  _r_: runnables      _m_: expand macro
  _d_: debugabbles    _c_: open cargo
  _s_: rustssr        _p_: parent module
  _h_: hover actions  _w_: reload workspace
  _D_: open docs      _g_: view create graph
^
  _i_: Toggle Inlay Hints     _q_: Exit
")

(Hydra {:name :Rust
        :hint rust-hint
        :config {:color :red
                 :invoke_on_body true
                 :hint {:position :middle :border :solid}}
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
