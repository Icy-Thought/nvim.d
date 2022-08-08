(local Hydra (require :hydra))
(local {: cmd} (require :hydra.keymap-util))

(local telescope-hint "
                    _f_: Files          _m_: Marks
     🭇🬭🬭🬭🬭🬭🬭🬭🬭🬼     _o_: Old Files      _g_: Live Grep
    🭉🭁🭠🭘    🭣🭕🭌🬾    _p_: Projects       _/_: Search in File
    🭅█ ▁     █🭐
    ██🬿      🭊██    _r_: Resume         _u_: Undo-tree
   🭋█🬝🮄🮄🮄🮄🮄🮄🮄🮄🬆█🭀   _h_: Vim Help       _c_: Execute Command
   🭤🭒🬺🬹🬱🬭🬭🬭🬭🬵🬹🬹🭝🭙   _k_: Keymaps        _;_: Commands History
                    _O_: Options        _?_: Search History
   ^
                    _<Enter>_: Telescope           _q_: Quit!
")

(Hydra {:name :Telescope
        :hint telescope-hint
        :config {:color :teal
                 :invoke_on_body true
                 :hint {:position :middle
                        :border :rounded}}
        :mode :n
        :body :<Leader>f
        :heads [[:f (cmd "Telescope find_files")]
                [:g (cmd "Telescope live_grep")]
                [:o (cmd "Telescope oldfiles") {:desc "recently opened files"}]
                [:h (cmd "Telescope help_tags") {:desc "vim help"}]
                [:m (cmd :MarksListBuf) {:desc :marks}]
                [:k (cmd "Telescope keymaps")]
                [:O (cmd "Telescope vim_options")]
                [:r (cmd "Telescope resume")]
                [:p (cmd "Telescope projects") {:desc :projects}]
                [:p (fn []
                      ((. (. (. (require :telescope) :extensions) :project)
                          :project) {:display_type :full}))
                    {:desc :projects}]
                ["/" (cmd "Telescope current_buffer_fuzzy_find") {:desc "search in file"}]
                ["?" (cmd "Telescope search_history") {:desc "search history"}]
                [";" (cmd "Telescope command_history") {:desc "command-line history"}]
                [:c (cmd "Telescope commands") {:desc "execute command"}]
                [:u (cmd "silent! %foldopen! | UndotreeToggle") {:desc :undotree}]
                [:<Enter> (cmd :NvimTreeToggle) {:exit true :desc "NvimTree"}]
                [:q nil {:exit true :nowait true}]]})
