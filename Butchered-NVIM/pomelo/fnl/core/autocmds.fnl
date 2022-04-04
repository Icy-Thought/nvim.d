(import-macros {: augroup!} :hibiscus.vim)

;; Packer autocommands
(autogroup! [...]
    [:BufWritePost] [:*/core/plugins.fnl] "PackerCompile profile=true"
    [:VimLeavePre] [:*/core/plugins.fnl :*/plugins/*.fnl]
    "PackerCompile profile=true"

    ;; Highlight yanked text
    [:TextYankPost] ["*"] "lua vim.highlight.on_yank({timeout = 300})"

    ;; Autosave
    [:TextChanged :InsertLeave] [:<buffer>] "silent! write"

    ;; Format on save
    [:BufWritePre] [:<buffer>] "silent! Format"

    ;; Preserve last editing position
    [:BufReadPost] ["*"]
    "lua require('core.autocmds.utils').preserve_position()"

    ;; Quickly exit help pages
    [:FileType] [:help] "nnoremap <silent> <buffer> q :q<cr>"

    ;; Set custom keybindings for netrw
    [:FileType] [:netrw] "lua require('core.netrw').set_netrw_maps()")
