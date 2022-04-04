(local {: setup} (require :Comment))

(setup :pre_hook
       (fn [ctx]
         ;; Only calculate commentstring for tsx filetypes
         (when (= vim.bo.filetype :typescriptreact)
           (local U (require :Comment.utils))
           (local type (or (and (= ctx.ctype U.ctype.line) :__default)
                           :__multiline))
           ;; Determine the location where to calculate commentstring from
           (var location nil)
           (if (= ctx.ctype U.ctype.block)
               (set location
                    ((. (require :ts_context_commentstring.utils)
                        :get_cursor_location)))
               (or (= ctx.cmotion U.cmotion.v)
                   (= ctx.cmotion U.cmotion.V))
               (set location
                    ((. (require :ts_context_commentstring.utils)
                        :get_visual_start_location))))
           ((. (require :ts_context_commentstring.internal)
               :calculate_commentstring) {:key type : location})))
       :post_hook nil)

;; Comment selected line
(map! [v] "/" "<ESC><cmd>lua require('Comment.api').toggle_linewise_op(vim.fn.visualmode())<cr>"
          "Comment Line")
;; Comment highlighted block
(map! [v] "[" "<ESC><cmd>lua require('Comment.api').toggle_blockwise_op(vim.fn.visualmode())<cr>"
          "Comment Block")
