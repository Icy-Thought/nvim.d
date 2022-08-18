;; TODO: rewrite to a better lisp variant

(local {: register_extension} (require :telescope))
(local finders (require :telescope.finders))
(local pickers (require :telescope.pickers))
(local make-entry (require :telescope.make_entry))
(local conf (. (require :telescope.config) :values))

(fn dotfiles-list [opts]
  (let [dir (or opts.path "")
        list {}
        p (io.popen (.. "rg --files --hidden " dir))]
    (each [file (p:lines)]
      (table.insert list file))
    (local nvim-conf (io.popen (.. "rg --files " (os.getenv :HOME)
                                   :/.config/nvim)))
    (each [file (nvim-conf:lines)]
      (table.insert list file))
    list))

(fn dotfiles [opts]
  (set-forcibly! opts (or opts {}))
  (local results (dotfiles-list opts))
  (: (pickers.new opts {:prompt_title "find in dotfiles"
                        :results_title :Dotfiles
                        :finder (finders.new_table {: results
                                                    :entry_maker (make-entry.gen_from_file opts)})
                        :previewer (conf.file_previewer opts)
                        :sorter (conf.file_sorter opts)}) :find))

(register_extension {:exports {: dotfiles}})
