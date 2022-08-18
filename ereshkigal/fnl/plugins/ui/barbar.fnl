(import-macros {: map!} :macros.keybind)

(local {: setup} (require :bufferline))

(setup {:animation true
        :auto_hide false
        :closable true
        :clickable true
        :exclude_ft {}
        :exclude_name {}
        :icons true
        :icon_custom_colors false
        :icon_separator_active "▎ "
        :icon_separator_inactive "▎ "
        :icon_close_tab " "
        :icon_close_tab_modified "● "
        :icon_pinned "車 "
        :insert_at_end false
        :insert_at_start false
        :maximum_padding 1
        :maximum_length 30
        :semantic_letters true
        :letters "asdfjkl;ghnmxcvbziowerutyqpASDFJKLGHNMXCVBZIOWERUTYQP"
        :no_name_title nil})

;; Prevent overlap between Nvim-Tree & Barbar
(local {: subscribe} (require :nvim-tree.events))
(local {: set_offset} (require :bufferline.state))

(fn get-tree-size []
  (. (. (require :nvim-tree.view) :View) :width))

(subscribe :TreeOpen
           (fn []
             (set_offset (get-tree-size))))
(subscribe :Resize
           (fn []
             (set_offset (get-tree-size))))

(subscribe :TreeClose
           (fn []
             (set_offset 0)))

;; Move between buffers -> previous || next
(map! [n] "<S-h>" :<CMD>BufferPrevious<CR> {:noremap true :silent true})
(map! [n] "<S-l>" :<CMD>BufferNext<CR> {:noremap true :silent true})

;; Re-order buffers -> previous || next
(map! [n] "<S-<>" :<CMD>BufferMovePrevious<CR> {:noremap true :silent true})
(map! [n] "<S->>" :<CMD>BufferMoveNext<CR> {:noremap true :silent true})

;; Pin/Unpin current buffer
(map! [n] "<S-p>" :<CMD>BufferPin<CR> {:noremap true :silent true})
(map! [n] "<S-c>" :<CMD>BufferClose<CR> {:noremap true :silent true})
