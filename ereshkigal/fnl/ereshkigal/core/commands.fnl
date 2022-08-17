(import-macros {: command!} :macros.command)

(command! Scratch "new | setlocal bt=nofile bh=wipe nobl noswapfile")
(command! SetScratch
          "edit [Scratch] | setlocal bt=nofile bh=wipe nobl noswapfile")

;; TODO: one function -> outcome = commands below
(command! PackerSync "lua require('core.packer') require('packer').sync()")
(command! PackerStatus "lua require('core.packer') require('packer').status()")
(command! PackerInstall "lua require('core.packer') require('packer').install()")
(command! PackerUpdate "lua require('core.packer') require('packer').update()")
(command! PackerCompile "lua require('core.packer') require('packer').compile()")

;; Emacs-like  scratch feature
(command! Scratch "lua require('utils.scratch').scratch()")