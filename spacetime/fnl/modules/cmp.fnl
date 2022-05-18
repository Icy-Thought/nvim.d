(local cmp (require :cmp))
(local luasnip (require :luasnip))

((. (require :luasnip.loaders.from_vscode) :lazy_load))
((. (require :luasnip.loaders.from_vscode) :lazy_load) {:paths {1 :./my-snippets}})

(fn check-backspace []
  (let [col (- (vim.fn.col ".") 1)]
    (or (= col 0) (: (: (vim.fn.getline ".") :sub col col) :match "%s"))))

(local kind-icons {:Text ""
                   :Method :m
                   :Function ""
                   :Constructor ""
                   :Field ""
                   :Variable ""
                   :Class ""
                   :Interface ""
                   :Module ""
                   :Property ""
                   :Unit ""
                   :Value ""
                   :Enum ""
                   :Keyword ""
                   :Snippet ""
                   :Color ""
                   :File ""
                   :Reference ""
                   :Folder ""
                   :EnumMember ""
                   :Constant ""
                   :Struct ""
                   :Event ""
                   :Operator ""
                   :TypeParameter ""})

(cmp.setup {:snippet {:expand (fn [args]
                                (luasnip.lsp_expand args.body))}
            :mapping {:<C-k> (cmp.mapping.select_prev_item)
                      :<C-j> (cmp.mapping.select_next_item)
                      :<C-b> (cmp.mapping (cmp.mapping.scroll_docs (- 1)) ["i" "c"])
                      :<C-f> (cmp.mapping (cmp.mapping.scroll_docs 1) ["i" "c"])
                      :<C-Space> (cmp.mapping (cmp.mapping.complete) ["i" "c"])
                      :<C-y> cmp.config.disable
                      :<C-e> (cmp.mapping {:i (cmp.mapping.abort)
                                           :c (cmp.mapping.close)})
                      :<CR> (cmp.mapping.confirm {:select true})
                      :<Tab> (cmp.mapping (fn [fallback]
                                            (if (cmp.visible)
                                                (cmp.select_next_item)
                                                (luasnip.expandable)
                                                (luasnip.expand)
                                                (luasnip.expand_or_jumpable)
                                                (luasnip.expand_or_jump)
                                                (check-backspace) (fallback)
                                                (fallback))) ["i" "s"])
                      :<S-Tab> (cmp.mapping (fn [fallback]
                                              (if (cmp.visible)
                                                  (cmp.select_prev_item)
                                                  (luasnip.jumpable (- 1))
                                                  (luasnip.jump (- 1))
                                                  (fallback))) ["i" "s"]}
            :formatting {:fields [:kind :abbr :menu]
                         :format (fn [entry vim-item]
                                   (set vim-item.kind
                                        (string.format "%s"
                                            (. kind-icons vim-item.kind)))
                                   (set vim-item.menu (. {:nvim_lsp "[LSP]"
                                                          :luasnip "[Snippet]"
                                                          :buffer "[Buffer]"
                                                          :path "[Path]"}
                                        entry.source.name)) vim-item)}
            :sources [{:name :nvim_lsp}
                      {:name :luasnip}
                      {:name :buffer}
                      {:name :path}]
            :confirm_opts {:behavior cmp.ConfirmBehavior.Replace 
                           :select false}
            :window {:completion (cmp.config.window.bordered)
                     :documentation (cmp.config.window.bordered)}
            :experimental {:ghost_text false 
                           :native_menu false}})
