(local {: setup} (require :formatter))
(local {: util} (require :formatter.util))

(local rs (require :formatter.filetypes.rust))
(local py (require :formatter.filetypes.python))

;; Language-specific Conf
(fn alejandra []
  {:exe :alejandra 
   :stdin true})

(fn markdown-cli []
  {:exe :markdownlint-cli2 
   :stdin true})

(fn prettier []
  {:exe :prettier
   :args [:--config-precedence
          :prefer-file
          :--stdin-filepath
          (vim.fn.fnameescape (vim.api.nvim_buf_get_name 0))
          :--single-quote
          :--no-semi
          :--arrow-parens
          :always
          :--print-width
          :100
          :--trailing-comma
          :all]
   :stdin true})

(fn stylish-hs []
  {:exe :stylish-haskell 
   :stdin true})

(fn stylua []
  {:exe :stylua
   :args [:--search-parent-directories
          :--stdin-filepath
          (util.escape_path (util.get_current_buffer_file_path))
          "--"
          "-"]
   :stdin true})

(setup {:logging true
        :log_level vim.log.levels.WARN
        :filetype {:* [(. (require :formatter.filetypes.any) 
                          :remove_trailing_whitespace)]
                   :c [(. (require :formatter.filetypes.lua)
                          :clangformat)]
                   :css [prettier]
                   :haskell [stylish-hs]
                   :javascript [prettier]
                   :jsonc [prettier]
                   :lua [stylua]
                   :markdown [markdown-cli]
                   :nix [alejandra]
                   :python [py.black py.isort]
                   :rust [rs.rustfmt]
                   :scss [prettier]
                   :typescript [prettier]
                   :yaml [prettier]}})

(local format-grp 
       (vim.api.nvim_create_augroup :FormatAutogroup {:clear true}))
(vim.api.nvim_create_autocmd :BufWritePost
                             {:pattern {1 "*"}
                              :command :FormatWrite
                              :group format-grp})	
