{...}: {
  modules.develop.lua.enable = true;

  hm.programs.neovim = let
    customPlugins =
      pkgs.callPackage "${nvimDir}/niflheim/custom-plugins.nix" pkgs;
    plugins = pkgs.vimPlugins // customPlugins;
  in {
    enable = true;
    package = pkgs.neovim-nightly;
    extraConfig = builtins.concatStringsSep "\n" [
      ''
        lua vim.cmd([[colorscheme ${colorscheme}]])
        luafile ${builtins.toString "${nvimDir}/niflheim/lua/options.lua"}
        luafile ${builtins.toString "${nvimDir}/niflheim/lua/keymaps.lua"}
        lua require('colorizer').setup()
        lua require('gitsigns').setup()
        lua require('neogit').setup()
        lua require('octo').setup()
        lua require('spectre').setup()
        lua require('toggleterm').setup()
        lua require('Comment').setup()
        lua require('trouble').setup()
        lua require('nvim-autopairs').setup()
      ''
    ];

    extraPackages = [
      pkgs.texlab
      pkgs.vale
    ];

    plugins = pkgs.callPackage "${nvimDir}/niflheim/plugins.nix" plugins;

    home.configFile."nvim/lua/my-snippets" = {
      source = "${nvimDir}/niflheim/my-snippets";
      recursive = true;
    };
  };
}
