{
  config,
  pkgs,
  ...
}: {
  modules.develop.lua.enable = true;

  hm.programs.neovim = let
    nvimDir = "${config.snowflake.configDir}/nvim.d";
    customPlugins = pkgs.callPackage "${nvimDir}/custom-plugins.nix" pkgs;
    plugins = pkgs.vimPlugins // customPlugins;
  in {
    enable = true;
    package = pkgs.neovim-nightly;
    extraConfig = builtins.concatStringsSep "\n" [
      ''
        luafile ${builtins.toString "${nvimDir}/lua/options.lua"}
        luafile ${builtins.toString "${nvimDir}/lua/keymaps.lua"}

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
    extraPackages = with pkgs; [texlab vale];
    plugins = pkgs.callPackage "${nvimDir}/plugins.nix" plugins;

    home.configFile.my-snippets = {
      target = "nvim/lua/my-snippets";
      source = "${nvimDir}/niflheim/my-snippets";
      recursive = true;
    };
    recursive = true;
  };
}
