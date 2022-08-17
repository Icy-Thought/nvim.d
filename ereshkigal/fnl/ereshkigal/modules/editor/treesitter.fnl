(local ts (require :nvim-treesitter))
(local tsq (require :nvim-treesitter.query))
(local tsp (require :nvim-treesitter.parsers))
(local {: setup} (require :nvim-treesitter.configs))

;;; Extra parsers
(local parser-config (tsp.get_parser_configs))

;; neorg treesitter parsers
(set parser-config.norg {:install_info {:url "https://github.com/nvim-neorg/tree-sitter-norg"
                                        :files [:src/parser.c :src/scanner.cc]
                                        :branch :main}})

(set parser-config.norg_meta
     {:install_info {:url "https://github.com/nvim-neorg/tree-sitter-norg-meta"
                     :files [:src/parser.c]
                     :branch :main}})

(set parser-config.norg_table
     {:install_info {:url "https://github.com/nvim-neorg/tree-sitter-norg-table"
                     :files [:src/parser.c]
                     :branch :main}})

;; WIP highlight/parse only buffer scope
(ts.define_modules
  {:ereshkigal-ts
   {:highlight_scope {:module_path :utils.ts-highlight-scope
                      :enable false
                      :disable []
                      :is_supported tsq.has_locals}}})

;; Initialize Treesitter
(setup {:ensure_installed :all
        :ignore_install [:phpdoc :norg]
        :highlight {:enable true :use_languagetree true}
        :indent {:enable true}
        :ereshkigal-ts {:highlight_scope {:enable true}}
        :incremental_selection {:enable true
                                :keymaps {:init_selection :gnn
                                          :node_incremental :grn
                                          :scope_incremental :grc
                                          :node_decremental :grm}}
        :textobjects {:select {:enable true}
                      :lookahead true
                      :keymaps {:af "@function.outer"
                                :if "@function.inner"
                                :il "@loop.inner"
                                :al "@loop.outer"
                                :icd "@conditional.inner"
                                :acd "@conditional.outer"
                                :acm "@comment.outer"
                                :ast "@statement.outer"
                                :isc "@scopename.inner"
                                :iB "@block.inner"
                                :aB "@block.outer"}
                      :move {:enable true
                             :set_jumps true
                             :goto_next_start {:gnf "@function.outer"
                                               :gnif "@function.inner"
                                               :gnp "@parameter.inner"
                                               :gnc "@call.outer"
                                               :gnic "@call.inner"}
                             :goto_next_end {:gnF "@function.outer"
                                             :gniF "@function.inner"
                                             :gnP "@parameter.inner"
                                             :gnC "@call.outer"
                                             :gniC "@call.inner"}
                             :goto_previous_start {:gpf "@function.outer"
                                                   :gpif "@function.inner"
                                                   :gpp "@parameter.inner"
                                                   :gpc "@call.outer"
                                                   :gpic "@call.inner"}
                             :goto_previous_end {:gpF "@function.outer"
                                                 :gpiF "@function.inner"
                                                 :gpP "@parameter.inner"
                                                 :gpC "@call.outer"
                                                 :gpiC "@call.inner"}}}})
