(import-macros {: set!} :macros.option)

(local {: insert} table)
(local {: setup
        : mapping
        : visible
        : select_prev_item
        : select_next_item
        : complete
        :config {: compare
                 : disable
                 :window {: bordered}}
        :ItemField {:Kind kind
                    :Abbr abbr
                    :Menu menu}
        :SelectBehavior {:Insert insert-behavior
                         :Select select-behavior}} (require :cmp))

(local types (require :cmp.types))
(local under-compare (require :cmp-under-comparator))
(local {: lsp_expand
        : expand_or_jump
        : expand_or_jumpable
        : jump
        : jumpable} (require :luasnip))

;; default icons (lspkind)
(local icons {:Text ""
              :Method ""
              :Function ""
              :Constructor "⌘"
              :Field "ﰠ"
              :Variable ""
              :Class "ﴯ"
              :Interface ""
              :Module ""
              :Unit "塞"
              :Property "ﰠ"
              :Value ""
              :Enum ""
              :Keyword "廓"
              :Snippet ""
              :Color ""
              :File ""
              :Reference ""
              :Folder ""
              :EnumMember ""
              :Constant ""
              :Struct "פּ"
              :Event ""
              :Operator ""
              :TypeParameter ""})

;;; Supertab functionality utility functions
(fn has-words-before []
  (let [col (- (vim.fn.col ".") 1)
        ln (vim.fn.getline ".")]
    (or (= col 0) (string.match (string.sub ln col col) "%s"))))

(fn replace-termcodes [code]
  (vim.api.nvim_replace_termcodes code true true true))

;;; cmp-setup
(setup {:preselect types.cmp.PreselectMode.None
        :experimental {:ghost_text true}
        :window {:completion (bordered)
                 :documentation (bordered)}
        :snippet {:expand (fn [args]
                            (lsp_expand args.body))}
        :mapping {:<CR> (mapping.confirm {:select true})
                  :<C-p> (mapping.select_prev_item)
                  :<C-n> (mapping.select_next_item)
                  :<C-d> (mapping.scroll_docs -4)
                  :<C-f> (mapping.scroll_docs 4)
                  :<C-e> (mapping.close)
                  :<Tab> (mapping (fn [fallback]
                                    (if (visible)
                                        (select_next_item)
                                        (expand_or_jumpable)
                                        (expand_or_jump)
                                        (has-words-before)
                                        (vim.fn.feedkeys (replace-termcodes :<Tab>) :n)
                                        (fallback)))
                                  [:i :s])
                  :<S-Tab> (mapping (fn [fallback]
                                      (if (visible)
                                          (select_prev_item)
                                          (jumpable -1)
                                          (jump -1)
                                          (fallback)))
                                    [:i :s])}
        :sources [{:name :nvim_lsp}
                  {:name :luasnip}
                  {:name :path}
                  {:name :buffer :option {:keyword_pattern "\\k\\+"}}
                  {:name :conjure}
                  {:name :crates}]
        :sorting {:comparators [compare.offset
                                compare.exact
                                compare.score
                                under-compare.under
                                compare.kind
                                compare.sort_text
                                compare.length
                                compare.order]}
        :formatting {:fields [:kind :abbr :menu]
                     :format (fn [_ vim-item]
                               (set vim-item.menu vim-item.kind)
                               (set vim-item.kind (. icons vim-item.kind))
                               vim-item)}})
