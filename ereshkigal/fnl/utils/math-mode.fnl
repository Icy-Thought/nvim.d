;; Provides a similar detection functionality to VimTex's `vimtex#syntax#in_mathzone`
;; with the help of nvim-treesitter. This allows LuaSnip to detect whether it is
;; located inside a math_environment or outside of it -> more efficient snippets!
;; https://github.com/nvim-treesitter/nvim-treesitter/issues/1184#issuecomment-1079844699

(local (has-treesitter ts) (pcall require :vim.treesitter))

(local (_ query) (pcall require :vim.treesitter.query))

(local MATH_NODES {:displayed_equation true
                   :inline_formula true
                   :math_environment true})

(local COMMENT {:comment true
                :line_comment true
                :block_comment true
                :comment_environment true})

(fn get-node-at-cursor []
  (let [buf (vim.api.nvim_get_current_buf)]
    (var (row col) (unpack (vim.api.nvim_win_get_cursor 0)))
    (set row (- row 1))
    (set col (- col 1))
    (local (ok parser) (pcall ts.get_parser buf :latex))
    (when (or (not ok) (not parser))
      (lua "return "))
    (local root-tree (. (parser:parse) 1))
    (local root (and root-tree (root-tree:root)))
    (when (not root)
      (lua "return "))
    (root:named_descendant_for_range row col row col)))

(fn in-comment? []
  (when has-treesitter
    (var node (get-node-at-cursor))
    (while node
      (when (. COMMENT (node:type))
        (lua "return true"))
      (set node (node:parent)))
    false))

(fn in-mathzone? []
  (when has-treesitter
    (var node (get-node-at-cursor))
    (while node
      (if (= (node:type) :text_mode) (lua "return false")
          (. MATH_NODES (node:type)) (lua "return true"))
      (set node (node:parent)))
    false))

{: in-comment?
 : in-mathzone?}
