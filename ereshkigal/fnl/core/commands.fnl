(import-macros {: command!} :macros.command)

(command! Scratch "new | setlocal bt=nofile bh=wipe nobl noswapfile")
(command! SetScratch "edit [Scratch] | setlocal bt=nofile bh=wipe nobl noswapfile")
