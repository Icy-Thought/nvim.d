# Welcome to Niflheim! 🌁
![Neovim](../../assets/neovim.png)

# Table of Contents
- [Greetings from NVIM! 🌒](#greetings-from-nvim-)
- [Sections](#sections)
- [Inspiration](#inspiration)

# Greetings from NVIM! 🌒
At the time of writing, the Neovim configuration files contained within the `lua` folder mostly consists of the recommended settings mentioned in the `README.md` of the installed plugins, while the remaining modifications belong to myself and other Neovim users. (`Ayamir's nvimdots`, `Abzcoding's lvim` & `Neovim From Scratch (LunarVim)`)

# Sections
Safety feature was added to the first configuration file that attempted to called `local x = require('x)` because of how Nix (Home-Manager) handles the Neovim config. To explain this, using Neovim through Home-Manager will generate *ONE* large file containing all the plugin configurations placed inside `config/nvim` -> omits the need to re-define it and create a non-useful boilerplate block.

``` lua
local function prequire(...)
    local status, lib = pcall(require, ...)
    if (status) then return lib end
    return nil
end
```

# Inspiration
- [NTBBloodbath/nvim.fnl](https:github.com/NTBBloodbath/nvim.fnl)
- [Ayamir/nvimdots](https:github.com/ayamir/nvimdots)
- [ABZCoding/lvim](https:github.com/abzcoding/lvim)
