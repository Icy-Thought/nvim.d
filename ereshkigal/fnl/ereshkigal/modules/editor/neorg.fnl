(local {: setup} (require :neorg))

(setup {:load {:core.defaults {}
               :core.export {}
               :core.gtd.base {:config {:workspace :GTD}}
               :core.keybinds {:config {:default_keybinds true}}
               :core.norg.completion {:config {:engine :nvim-cmp}}
               :core.norg.dirman {:config {:autochdir true
                                           :autodetect true
                                           :workspaces {:work "~/Notes/Neorg/Work"
                                                        :home "~/Notes/Neorg/Journal"
                                                        :GTD "~/Notes/Neorg/GTD"}}}
               :core.norg.qol.toc {:config {:default_toc_mode :split
                                            :toc_split_placement :right}}
               :core.norg.journal {:config {:workspace "~/Notes/Neorg/Journal"
                                            :strategy :nested}}
               :core.presenter {:config {:zen_mode :truezen}}}})

