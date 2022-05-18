(local configs (require :nvim-treesitter.configs))

(configs.setup {:ensure_installed ["c"
                                   "haskell"
                                   "lua"
                                   "nix"
                                   "python"
                                   "rust"]
                :sync_install false
                :ignore_install []
                :autopairs {:enable true}
                :highlight {:enable true
                            :disable [""]
                            :additional_vim_regex_highlighting false}
                :indent {:enable true 
                         :disable []}
                :context_commentstring {:enable true 
                                        :enable_autocmd false}})
