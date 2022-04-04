(local {: setup} (require :bufferline))

(setup :options {:mode "buffers"
                 :numbers "none"
                 :number_style "superscript"
                 ;; Buffer close behaviour
                 :close_command "bdelete! %d"
                 :right_mouse_command nil
                 :left_mouse_command "buffer %d"
                 :middle_mouse_command "bdelete! %d"
                 ;; Displayed icons
                 ; NOTE: plugin is designed with this icon in mind -> do not change.
                 :indicator_icon "▎"
                 :buffer_close_icon ""
                 :modified_icon "●"
                 :close_icon ""
                 :left_trunc_marker ""
                 :right_trunc_marker ""
                 :show_buffer_icons true
                 :show_buffer_close_icons true
                 :show_close_icon true
                 :show_tab_indicators true
                 :separator_style "thin"
                 ;; Control tab sizing
                 :max_name_length = 18
                 :max_prefix_length = 15
                 :tab_size = 18
                 :diagnostics "nvim_lsp"
                 :offsets [{:filetype "NvimTree" 
                            :highlight "Directory"
                            :text_align "left"
                            :text "File Explorer"
                            :padding 1}]
                 :sort_by "id"})
