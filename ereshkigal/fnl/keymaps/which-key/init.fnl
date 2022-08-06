(local wk (require :which-key))
(local opts {:mode :n
             :prefix :<leader>
             :buffer nil
             :silent true
             :noremap true
             :nowait true})

(local mappings {:/ ["<CMD>Telescope live_grep<CR>" "Search Project"]
                 " " ["<CMD>Telescope find_files<CR>" "Find File"]
                 :d {:<CMD>Dashboard<CR> "Launch Dashboard"}
                 :e {:<CMD>NvimTreeToggle<CR> "File Explorer"}
                 :n {:<CMD>nohlsearch<CR> "No Highlight"}
                 :b {:name :Buffer
                     "[" [:<CMD><CR> "Previous Buffer"]
                     "]" [:<CMD><CR> "Next Buffer"]
                     :b ["<CMD>Telescope buffers<CR>" "Switch Buffer"]
                     :d [:<CMD>bd!<CR> "Close Buffer"]
                     :O ["<CMD>%bd|e#<CR>" "Close Buffers Except Current Buf"]}
                 :f {:name :Find
                     :f ["<CMD>Telescope file_browser path=%:p:h<CR>"
                         "Browse Files"]
                     :p ["<CMD>Telescope dotfiles<CR>" "Open Private Config"]
                     :r ["<CMD>lua require('telescope').extensions.frecency.frecency()<CR>"
                         "List Frequent File"]
                     :R ["<CMD>Telescope oldfiles<CR>" "Open Recent File"]
                     :s [:<CMD>w!<CR> "Save Buffer"]}
                 :g {:name :Git
                     :b ["<CMD>Telescope git_branches<CR>" "Checkout Branch"]
                     :c ["<CMD>Telescope git_commits<CR>" "Checkout Commit"]
                     :d ["<CMD>Gitsigns diffthis HEAD<CR>" :Diff]
                     :g [:<CMD>Neogit<CR> "Launch Neogit"]
                     :j ["<CMD>Gitsigns next_hunk<CR>" "Next Change"]
                     :k ["<CMD>Gitsigns prev_hunk<CR>" "Prev Change"]
                     :l ["<CMD>Gitsigns blame_line<CR>" :Blame]
                     :o ["<CMD>Telescope git_status<CR>" "Open Changed File"]
                     :p ["<CMD>Gitsigns preview_hunk<CR>" "Preview Changes"]
                     :r ["<CMD>Gitsigns reset_hunk<CR>" "Restore File"]
                     :R ["<CMD>Gitsigns reset_buffer<CR>" "Reset Buffer"]
                     :s ["<CMD>Gitsigns stage_hunk<CR>" "Stage Changes"]
                     :u ["<CMD>Gitsigns undo_stage_hunk<CR>" "Undo Stage Hunk"]}
                 :h {:name :Help
                     :c ["<CMD>Telescope commands<CR>"
                         "List Available Commands"]
                     :h ["<CMD>Telescope help_tags<CR>" "Find Help"]
                     :k ["<CMD>Telescope keymaps<CR>" "List Keybindings"]
                     :m ["<CMD>Telescope man_pages<CR>" "Man Pages"]}
                 :l {:name "Language Server"}
                 :o {:name "Launch X"}
                 :p {:name "Packer & Project"
                     :p ["<CMD>Telescope project<CR>" "Select Project"]
                     :t [:<CMD>TodoTelescope<CR> "List Project Tasks"]
                     :u [:<CMD>PackerSync<CR> "Packer Synchronize"]}
                 :q {:name :Quit!
                     :d ["<CMD>%bd|Dashboard<CR>" "All Buffers"]
                     :q [:<CMD>q!<CR> "Nvim (NO SAVE)"]}
                 :w {:name "Buffer Navigation"
                     :c [:<CMD>bd!<CR> "Close Buffer"]
                     :h [:<c-w>h "Displace Left"]
                     :j [:<c-w>j "Displace Downwards"]
                     :k [:<c-w>k "Displace Upwards"]
                     :l [:<c-w>l "Displace Right"]}})

(wk.register mappings opts)
