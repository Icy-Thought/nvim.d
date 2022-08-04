(local {: setup} (require :neorg))

(setup {:load {:core.defaults {}
               :core.norg.completion {:config {:engine :nvim-cmp}}
               :core.norg.concealer {:config {:markup_preset :dimmed
                                     :icon_preset :diamond
                                     :dim_code_blocks true}}
                :core.norg.dirman {:config {:workspaces {:work "~/Notes/Neorg/Work"
                                            :home "~/Notes/Neorg/Journal"
                                            :GTD "~/Notes/Neorg/GTD"}
                                   :autochdir true
                                   :autodetect true
                                   :open_last_workspace true
                                   :default_workspace :home}}
                :core.gtd.base {:config {:workspace :GTD}}
                :core.keybinds {:config {:default_keybinds true}}
                :core.norg.journal {:config {:workspace "~/Notes/Neorg/Journal"
                                             :strategy :nested}}
                :core.presenter {:config {:zen_mode :truezen}}
                :core.norg.qol.toc {:config {:default_toc_mode :split
                                             :toc_split_placement :left
                                             :close_split_on_jump false}}}})
