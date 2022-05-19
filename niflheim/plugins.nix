plugins: let
  readLuaFile = file: builtins.readFile (./. + "/${file}.lua");
  plugWithCfg = plugin: {
    inherit plugin;
    type = "lua";
    config = readLuaFile "lua/config/${plugin.pname}/init";
  };
  initPlug = plugin: pcall: {
    plugins = plugin;
    config = "require('${pcall}').setup();";
  };
in
  with plugins; [
    # Plugins with Configurations
    (plugWithCfg catppuccin-nvim)
    # (plugWithCfg kanagawa-nvim)
    # (plugWithCfg rose-pine)

    (plugWithCfg dashboard-nvim)
    (plugWithCfg lualine-nvim)
    (plugWithCfg bufferline-nvim)
    (plugWithCfg which-key-nvim)
    (plugWithCfg wilder-nvim)
    fzy-lua-native # wilder dep.

    (plugWithCfg telescope-nvim)
    telescope-file-browser-nvim
    telescope-frecency-nvim
    telescope-fzf-native-nvim
    telescope-project-nvim

    cmp-nvim-lsp
    cmp-buffer
    cmp-path
    cmp-cmdline
    cmp_luasnip
    luasnip
    friendly-snippets
    (plugWithCfg nvim-treesitter)
    nvim-ts-context-commentstring
    (plugWithCfg null-ls-nvim)
    (plugWithCfg nvim-lspconfig)
    (plugWithCfg nvim-cmp)

    (plugWithCfg copilot-vim)
    (plugWithCfg indent-blankline-nvim)
    (plugWithCfg nvim-tree-lua)
    (plugWithCfg markdown-preview-nvim)
    (plugWithCfg todo-comments-nvim)
    (plugWithCfg vimtex)
    latex-snippets

    # Plugins configured in Nix module
    ## impatient-nvim
    nvim-colorizer-lua
    gitsigns-nvim
    nvim-web-devicons
    neogit
    octo-nvim
    nvim-spectre
    toggleterm-nvim
    comment-nvim
    trouble-nvim
    nvim-autopairs
  ]
