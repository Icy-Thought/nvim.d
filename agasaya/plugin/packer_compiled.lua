-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

  local time
  local profile_info
  local should_profile = false
  if should_profile then
    local hrtime = vim.loop.hrtime
    profile_info = {}
    time = function(chunk, start)
      if start then
        profile_info[chunk] = hrtime()
      else
        profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
      end
    end
  else
    time = function(chunk, start) end
  end
  
local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end

  _G._packer = _G._packer or {}
  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/home/icy-thought/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/home/icy-thought/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/home/icy-thought/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/home/icy-thought/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/home/icy-thought/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s), name, _G.packer_plugins[name])
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  ["Comment.nvim"] = {
    config = { " prequire('Comment', {}) " },
    loaded = true,
    path = "/home/icy-thought/.local/share/nvim/site/pack/packer/start/Comment.nvim",
    url = "https://github.com/numToStr/Comment.nvim"
  },
  LuaSnip = {
    loaded = true,
    path = "/home/icy-thought/.local/share/nvim/site/pack/packer/start/LuaSnip",
    url = "https://github.com/L3MON4D3/LuaSnip"
  },
  ayu = {
    config = { " prequire('themes.ayu') " },
    loaded = false,
    needs_bufread = false,
    path = "/home/icy-thought/.local/share/nvim/site/pack/packer/opt/ayu",
    url = "https://github.com/Shatur/neovim-ayu"
  },
  ["bufferline.nvim"] = {
    config = { " prequire('modules.bufferline') " },
    loaded = true,
    path = "/home/icy-thought/.local/share/nvim/site/pack/packer/start/bufferline.nvim",
    url = "https://github.com/akinsho/bufferline.nvim"
  },
  catppuccin = {
    config = { " prequire('themes.catppuccin') " },
    loaded = false,
    needs_bufread = false,
    path = "/home/icy-thought/.local/share/nvim/site/pack/packer/opt/catppuccin",
    url = "https://github.com/catppuccin/nvim"
  },
  ["cmp-buffer"] = {
    loaded = true,
    path = "/home/icy-thought/.local/share/nvim/site/pack/packer/start/cmp-buffer",
    url = "https://github.com/hrsh7th/cmp-buffer"
  },
  ["cmp-cmdline"] = {
    loaded = true,
    path = "/home/icy-thought/.local/share/nvim/site/pack/packer/start/cmp-cmdline",
    url = "https://github.com/hrsh7th/cmp-cmdline"
  },
  ["cmp-nvim-lsp"] = {
    loaded = true,
    path = "/home/icy-thought/.local/share/nvim/site/pack/packer/start/cmp-nvim-lsp",
    url = "https://github.com/hrsh7th/cmp-nvim-lsp"
  },
  ["cmp-path"] = {
    loaded = true,
    path = "/home/icy-thought/.local/share/nvim/site/pack/packer/start/cmp-path",
    url = "https://github.com/hrsh7th/cmp-path"
  },
  cmp_luasnip = {
    loaded = true,
    path = "/home/icy-thought/.local/share/nvim/site/pack/packer/start/cmp_luasnip",
    url = "https://github.com/saadparwaiz1/cmp_luasnip"
  },
  ["dashboard-nvim"] = {
    config = { " prequire('modules.dashboard') " },
    loaded = true,
    path = "/home/icy-thought/.local/share/nvim/site/pack/packer/start/dashboard-nvim",
    url = "https://github.com/ChristianChiarulli/dashboard-nvim"
  },
  ["friendly-snippets"] = {
    loaded = true,
    path = "/home/icy-thought/.local/share/nvim/site/pack/packer/start/friendly-snippets",
    url = "https://github.com/rafamadriz/friendly-snippets"
  },
  ["gitsigns.nvim"] = {
    config = { " prequire('gitsigns', {}) " },
    loaded = true,
    path = "/home/icy-thought/.local/share/nvim/site/pack/packer/start/gitsigns.nvim",
    url = "https://github.com/lewis6991/gitsigns.nvim"
  },
  ["indent-blankline.nvim"] = {
    config = { " prequire('modules.blankline') " },
    loaded = true,
    path = "/home/icy-thought/.local/share/nvim/site/pack/packer/start/indent-blankline.nvim",
    url = "https://github.com/lukas-reineke/indent-blankline.nvim"
  },
  ["lualine.nvim"] = {
    config = { " prequire('modules.lualine') " },
    loaded = true,
    path = "/home/icy-thought/.local/share/nvim/site/pack/packer/start/lualine.nvim",
    url = "https://github.com/nvim-lualine/lualine.nvim"
  },
  ["luasnip-latex-snippets.nvim"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/icy-thought/.local/share/nvim/site/pack/packer/opt/luasnip-latex-snippets.nvim",
    url = "https://github.com/iurimateus/luasnip-latex-snippets.nvim"
  },
  ["markdown-preview.nvim"] = {
    config = { " prequire('modules.md-preview') " },
    loaded = true,
    path = "/home/icy-thought/.local/share/nvim/site/pack/packer/start/markdown-preview.nvim",
    url = "https://github.com/iamcco/markdown-preview.nvim"
  },
  neogit = {
    config = { " prequire('neogit', {}) " },
    loaded = true,
    path = "/home/icy-thought/.local/share/nvim/site/pack/packer/start/neogit",
    url = "https://github.com/TimUntersberger/neogit"
  },
  ["null-ls.nvim"] = {
    config = { " prequire('modules.null-ls') " },
    loaded = true,
    path = "/home/icy-thought/.local/share/nvim/site/pack/packer/start/null-ls.nvim",
    url = "https://github.com/jose-elias-alvarez/null-ls.nvim"
  },
  ["nvim-autopairs"] = {
    config = { " prequire('nvim-autopairs', {}) " },
    loaded = true,
    path = "/home/icy-thought/.local/share/nvim/site/pack/packer/start/nvim-autopairs",
    url = "https://github.com/windwp/nvim-autopairs"
  },
  ["nvim-cmp"] = {
    config = { " prequire('modules.cmp') " },
    loaded = true,
    path = "/home/icy-thought/.local/share/nvim/site/pack/packer/start/nvim-cmp",
    url = "https://github.com/hrsh7th/nvim-cmp"
  },
  ["nvim-colorizer.lua"] = {
    config = { " prequire('colorizer', {}) " },
    loaded = true,
    path = "/home/icy-thought/.local/share/nvim/site/pack/packer/start/nvim-colorizer.lua",
    url = "https://github.com/norcalli/nvim-colorizer.lua"
  },
  ["nvim-lspconfig"] = {
    config = { " prequire('modules.lspconfig') " },
    loaded = true,
    path = "/home/icy-thought/.local/share/nvim/site/pack/packer/start/nvim-lspconfig",
    url = "https://github.com/neovim/nvim-lspconfig"
  },
  ["nvim-spectre"] = {
    config = { " prequire('spectre', {}) " },
    loaded = true,
    path = "/home/icy-thought/.local/share/nvim/site/pack/packer/start/nvim-spectre",
    url = "https://github.com/windwp/nvim-spectre"
  },
  ["nvim-toggleterm.lua"] = {
    config = { " prequire('toggleterm', {}) " },
    loaded = true,
    path = "/home/icy-thought/.local/share/nvim/site/pack/packer/start/nvim-toggleterm.lua",
    url = "https://github.com/akinsho/nvim-toggleterm.lua"
  },
  ["nvim-tree.lua"] = {
    config = { " prequire('nvim-tree', {}) " },
    loaded = true,
    path = "/home/icy-thought/.local/share/nvim/site/pack/packer/start/nvim-tree.lua",
    url = "https://github.com/kyazdani42/nvim-tree.lua"
  },
  ["nvim-treesitter"] = {
    config = { " prequire('modules.treesitter') " },
    loaded = true,
    path = "/home/icy-thought/.local/share/nvim/site/pack/packer/start/nvim-treesitter",
    url = "https://github.com/nvim-treesitter/nvim-treesitter"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/home/icy-thought/.local/share/nvim/site/pack/packer/start/nvim-web-devicons",
    url = "https://github.com/kyazdani42/nvim-web-devicons"
  },
  ["octo.nvim"] = {
    config = { " prequire('octo', {}) " },
    loaded = true,
    path = "/home/icy-thought/.local/share/nvim/site/pack/packer/start/octo.nvim",
    url = "https://github.com/pwntester/octo.nvim"
  },
  ["onedark-pro"] = {
    config = { " prequire('themes.onedark-pro') " },
    loaded = false,
    needs_bufread = false,
    path = "/home/icy-thought/.local/share/nvim/site/pack/packer/opt/onedark-pro",
    url = "https://github.com/olimorris/onedarkpro.nvim"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/home/icy-thought/.local/share/nvim/site/pack/packer/start/packer.nvim",
    url = "https://github.com/wbthomason/packer.nvim"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/home/icy-thought/.local/share/nvim/site/pack/packer/start/plenary.nvim",
    url = "https://github.com/nvim-lua/plenary.nvim"
  },
  ["rose-pine"] = {
    config = { " prequire('themes.rose-pine') " },
    loaded = false,
    needs_bufread = false,
    path = "/home/icy-thought/.local/share/nvim/site/pack/packer/opt/rose-pine",
    url = "https://github.com/rose-pine/neovim"
  },
  ["telescope-file-browser.nvim"] = {
    loaded = true,
    path = "/home/icy-thought/.local/share/nvim/site/pack/packer/start/telescope-file-browser.nvim",
    url = "https://github.com/nvim-telescope/telescope-file-browser.nvim"
  },
  ["telescope-frecency.nvim"] = {
    loaded = true,
    path = "/home/icy-thought/.local/share/nvim/site/pack/packer/start/telescope-frecency.nvim",
    url = "https://github.com/nvim-telescope/telescope-frecency.nvim"
  },
  ["telescope-fzf-native.nvim"] = {
    loaded = true,
    path = "/home/icy-thought/.local/share/nvim/site/pack/packer/start/telescope-fzf-native.nvim",
    url = "https://github.com/nvim-telescope/telescope-fzf-native.nvim"
  },
  ["telescope-project.nvim"] = {
    loaded = true,
    path = "/home/icy-thought/.local/share/nvim/site/pack/packer/start/telescope-project.nvim",
    url = "https://github.com/nvim-telescope/telescope-project.nvim"
  },
  ["telescope.nvim"] = {
    config = { " prequire('modules.telescope') " },
    loaded = true,
    path = "/home/icy-thought/.local/share/nvim/site/pack/packer/start/telescope.nvim",
    url = "https://github.com/nvim-telescope/telescope.nvim"
  },
  ["todo-comments.nvim"] = {
    config = { " prequire('todo-comments', {}) " },
    loaded = true,
    path = "/home/icy-thought/.local/share/nvim/site/pack/packer/start/todo-comments.nvim",
    url = "https://github.com/folke/todo-comments.nvim"
  },
  ["trouble.nvim"] = {
    config = { " prequire('trouble', {}) " },
    loaded = true,
    path = "/home/icy-thought/.local/share/nvim/site/pack/packer/start/trouble.nvim",
    url = "https://github.com/folke/trouble.nvim"
  },
  vimtex = {
    config = { " prequire('modules.vimtex') " },
    loaded = true,
    path = "/home/icy-thought/.local/share/nvim/site/pack/packer/start/vimtex",
    url = "https://github.com/lervag/vimtex"
  },
  ["which-key.nvim"] = {
    config = { " prequire('modules.which-key') " },
    loaded = true,
    path = "/home/icy-thought/.local/share/nvim/site/pack/packer/start/which-key.nvim",
    url = "https://github.com/folke/which-key.nvim"
  },
  ["wilder.nvim"] = {
    config = { " prequire('modules.wilder') " },
    loaded = true,
    path = "/home/icy-thought/.local/share/nvim/site/pack/packer/start/wilder.nvim",
    url = "https://github.com/gelguy/wilder.nvim"
  }
}

time([[Defining packer_plugins]], false)
-- Config for: nvim-cmp
time([[Config for nvim-cmp]], true)
 prequire('modules.cmp') 
time([[Config for nvim-cmp]], false)
-- Config for: lualine.nvim
time([[Config for lualine.nvim]], true)
 prequire('modules.lualine') 
time([[Config for lualine.nvim]], false)
-- Config for: octo.nvim
time([[Config for octo.nvim]], true)
 prequire('octo', {}) 
time([[Config for octo.nvim]], false)
-- Config for: bufferline.nvim
time([[Config for bufferline.nvim]], true)
 prequire('modules.bufferline') 
time([[Config for bufferline.nvim]], false)
-- Config for: nvim-colorizer.lua
time([[Config for nvim-colorizer.lua]], true)
 prequire('colorizer', {}) 
time([[Config for nvim-colorizer.lua]], false)
-- Config for: nvim-spectre
time([[Config for nvim-spectre]], true)
 prequire('spectre', {}) 
time([[Config for nvim-spectre]], false)
-- Config for: Comment.nvim
time([[Config for Comment.nvim]], true)
 prequire('Comment', {}) 
time([[Config for Comment.nvim]], false)
-- Config for: wilder.nvim
time([[Config for wilder.nvim]], true)
 prequire('modules.wilder') 
time([[Config for wilder.nvim]], false)
-- Config for: nvim-lspconfig
time([[Config for nvim-lspconfig]], true)
 prequire('modules.lspconfig') 
time([[Config for nvim-lspconfig]], false)
-- Config for: nvim-autopairs
time([[Config for nvim-autopairs]], true)
 prequire('nvim-autopairs', {}) 
time([[Config for nvim-autopairs]], false)
-- Config for: telescope.nvim
time([[Config for telescope.nvim]], true)
 prequire('modules.telescope') 
time([[Config for telescope.nvim]], false)
-- Config for: nvim-treesitter
time([[Config for nvim-treesitter]], true)
 prequire('modules.treesitter') 
time([[Config for nvim-treesitter]], false)
-- Config for: null-ls.nvim
time([[Config for null-ls.nvim]], true)
 prequire('modules.null-ls') 
time([[Config for null-ls.nvim]], false)
-- Config for: todo-comments.nvim
time([[Config for todo-comments.nvim]], true)
 prequire('todo-comments', {}) 
time([[Config for todo-comments.nvim]], false)
-- Config for: indent-blankline.nvim
time([[Config for indent-blankline.nvim]], true)
 prequire('modules.blankline') 
time([[Config for indent-blankline.nvim]], false)
-- Config for: which-key.nvim
time([[Config for which-key.nvim]], true)
 prequire('modules.which-key') 
time([[Config for which-key.nvim]], false)
-- Config for: gitsigns.nvim
time([[Config for gitsigns.nvim]], true)
 prequire('gitsigns', {}) 
time([[Config for gitsigns.nvim]], false)
-- Config for: trouble.nvim
time([[Config for trouble.nvim]], true)
 prequire('trouble', {}) 
time([[Config for trouble.nvim]], false)
-- Config for: markdown-preview.nvim
time([[Config for markdown-preview.nvim]], true)
 prequire('modules.md-preview') 
time([[Config for markdown-preview.nvim]], false)
-- Config for: nvim-toggleterm.lua
time([[Config for nvim-toggleterm.lua]], true)
 prequire('toggleterm', {}) 
time([[Config for nvim-toggleterm.lua]], false)
-- Config for: nvim-tree.lua
time([[Config for nvim-tree.lua]], true)
 prequire('nvim-tree', {}) 
time([[Config for nvim-tree.lua]], false)
-- Config for: neogit
time([[Config for neogit]], true)
 prequire('neogit', {}) 
time([[Config for neogit]], false)
-- Config for: dashboard-nvim
time([[Config for dashboard-nvim]], true)
 prequire('modules.dashboard') 
time([[Config for dashboard-nvim]], false)
-- Config for: vimtex
time([[Config for vimtex]], true)
 prequire('modules.vimtex') 
time([[Config for vimtex]], false)
vim.cmd [[augroup packer_load_aucmds]]
vim.cmd [[au!]]
  -- Filetype lazy-loads
time([[Defining lazy-load filetype autocommands]], true)
vim.cmd [[au FileType tex ++once lua require("packer.load")({'luasnip-latex-snippets.nvim'}, { ft = "tex" }, _G.packer_plugins)]]
time([[Defining lazy-load filetype autocommands]], false)
vim.cmd("augroup END")
if should_profile then save_profiles() end

end)

if not no_errors then
  error_msg = error_msg:gsub('"', '\\"')
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
