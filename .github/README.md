<p align="center">
  <img src="./assets/png/knight-chess.png" alt="Knight (Chess)" width="300" height="300"/>
</p>

# Neovim Dotfiles

This repository consists of:

1. `niflheim`: a configuration I stitched together with the help of the default
   settings of the installed plugin mentioned in the project's README. 

2. `ereshkigal`: lisp-based neovim setup. 

3. `agasaya`: lua-based neovim setup. 

# Agasaya

![Agasaya](./assets/png/agasaya.png)

Agasaya is a non nix-dependent neovim configuration file that I crafted myself
and consists mainly of a minimal setup and neovide settings for the sake of
having a neovim-gui available.

You might notice that there is a missing `init.lua` file in this folder and the
reason for that is that I have decided to generate it through `home-manager`
(Nix) to automate the theme selection process on desktop theme change!

## Sections

Instead of directly using `require('xyz')`, I have instead chosen to write a
function which requires only when the plugin exists, otherwise it returns
nothing.

```lua
local function prequire(...)
    local success, lib = pcall(require, ...)
    if not (success) then return lib end
    return nil
end
