(local db (require :dashboard))

(local config-dir (vim.fn.stdpath :config))

;; Find a way to reduce font size for proper sizing
(set db.custom_header (vim.fn.systemlist
                        (.. "cat " config-dir :/dasHead.txt)))

(set db.custom_center [{:icon "   "
                        :desc "Switch Colorscheme                          "
                        :shortcut "SPC s c"
                        :action "Telescope colorscheme"}

                       {:icon "  "
                        :desc "File Frecency                               "
                        :shortcut "SPC f r"
                        :action "lua require('telescope').extensions.frecency.frecency()"}

                       {:icon "  "
                        :desc "File Browser                                "
                        :shortcut "SPC f f"
                        :action "Telescope file_browser"}

                       {:icon "  "
                        :desc "New File                                    "
                        :shortcut "SPC f n"
                        :action :DashboardNewFile}

                       {:icon "  "
                        :desc "Find Project                                "
                        :shortcut "SPC f p"
                        :action "Telescope project"}

                       {:icon "  "
                        :desc "Browse Neovim Dotfiles                      "
                        :action (.. "Telescope dotfiles path=" config-dir)
                        :shortcut "SPC f d"}

                       {:icon "  "
                        :desc "Update Plugins                              "
                        :shortcut "SPC u u"
                        :action :PackerUpdate}

                       {:icon "  "
                        :desc "Quit                                        "
                        :shortcut "SPC q q"
                        :action :q}])
