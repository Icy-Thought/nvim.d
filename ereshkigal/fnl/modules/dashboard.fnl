(import-macros {: g!} :hibiscus.vim)

(g! dashboard_footer_icon "🐬 ")
(g! dashboard_default_executive :telescope)

(local config-dir (vim.fn.stdpath :config))

(g! dashboard_custom_header
    (vim.fn.systemlist (.. "cat" config-dir "./dasHead.txt")))

(g! dashboard_custom_section
    {:a {:description [" Scheme change              SPC s c"]
         :command "DashboardChangeColorscheme"}
     :b {:description [" File Frecency              SPC f r "]
         :command "Telescope frecency"}
     :c {:description [" File History               SPC f e "]
         :command "DashboardFindHistory"}
     :d {:description [" Find Project               SPC f p"]
         :command "Telescope project"}
     :e {:description [" Find File                  SPC f f"]
         :command "DashboardFindFile"}
     :f {:description [" New File                   SPC f n"]
         :command "DashboardNewFile"}
     :g {:description [" Find word                  SPC f w"]
         :command "DashboardFindWord"}})
