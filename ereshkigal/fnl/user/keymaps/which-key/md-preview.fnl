(import-macros {: map!} :macros.keybind)

(map! [n] :<leader>mp :<CMD>MarkdownPreview<CR>
      {:noremap true :silent true :desc "Preview Markdown File"})

(map! [n] :<leader>ms :<CMD>MarkdownPreviewStop<CR>
      {:noremap true :silent true :desc "Terminate Markdown Preview"})

(map! [n] :<leader>mt :<CMD>MarkdownPreviewToggle<CR>
      {:noremap true :silent true :desc "Toggle Markdown Preview"})

(local category {:m {:name "Markdown Preview"}})
((. (require :which-key) :register) category)
