(import-macros {: map!} :macros.keybind)

(local {: setup} (require :bufferline))

(setup {:options {:numbers :none
                  :close_command "bdelete! %d"
                  :right_mouse_command "bdelete! %d"
                  :left_mouse_command "buffer %d"
                  :middle_mouse_command nil
                  :indicator_icon "▎"
                  :buffer_close_icon ""
                  :modified_icon "●"
                  :close_icon ""
                  :left_trunc_marker ""
                  :right_trunc_marker ""
                  :max_name_length 18
                  :max_prefix_length 15
                  :tab_size 18
                  :diagnostics false
                  :offsets [{:filetype
                             :NvimTree
                             :text ""
                             :padding 1}]
                  :show_buffer_icons true
                  :show_buffer_close_icons true
                  :show_close_icon true
                  :show_tab_indicators true
                  :persist_buffer_sort true
                  :separator_style :thin
                  :enforce_regular_tabs true
                  :always_show_bufferline true
                  :sort_by :id}})

;; Navigate buffers
(map! [n] :<S-l> :<CMD>bnext<CR> {:noremap true :silent true})
(map! [n] :<S-h> :<CMD>bprevious<CR> {:noremap true :silent true})
