(local {: custom_header
        : custom_center} (require :dashboard))

(local config-dir (vim.fn.stdpath :config))
(custom_header (vim.fn.systemlist 
                 (.. "cat " config-dir :/dasHead.txt)))

(custom_center [{:icon "  "
                 :desc (.. "Switch Colorscheme" "                    ")
                 :shortcut "SPC s c"
                 :action "Telescope colorscheme"}

                {:icon "  "
                 :desc (.. "File Frecency" "                         ")
                 :shortcut "SPC f r"
                 :action "Telescope frecency"}

                {:icon "  "
                 :desc (.. "Find File" "                             ")
                 :shortcut "SPC f f"
                 :action "Telescope find_files"}

                {:icon "  "
                 :desc (.. "New File" "                              ")
                 :shortcut "SPC f n"
                 :action :DashboardNewFile}

                {:icon "  "
                 :desc (.. "Find Project" "                          ")
                 :shortcut "SPC f p"
                 :action "Telescope project"}

                {:icon "  "
                 :desc (.. "Browse Neovim Dotfiles" "                ")
                 :action (.. "Telescope dotfiles path=" config-dir)
                 :shortcut "SPC f d"}

                {:icon "  "
                 :desc (.. "Update Plugins" "                        ")
                 :shortcut "SPC u u"
                 :action :PackerUpdate}

                {:icon "  "
                 :desc (.. "Quit" "                                  ")
                 :shortcut "SPC q q"
                 :action :q}])
