{ config, pkgs, lib, ... }: {

  options.neovim.enable = lib.mkEnableOption "Enable NeoVim";

  config = lib.mkIf config.neovim.enable {
    home-manager.users.${config.user} = {

      home.packages = with pkgs; [
        neovim
        # AstroNvim dependencies
        bottom
        tree-sitter
        lazygit
      ];

      home.sessionVariables = { MANPAGER = "nvim +Man!"; };

      # Configura Neovim with Astro
      home.file.astroNvim = {
        source = pkgs.fetchFromGitHub {
          owner = "thonyprice";
          repo = "AstroNvim";
          rev = "9404f49";
          sha256 = "aQb472pQRJHaCCkC+fvLye/VtUr40IJZbv3PaM0FCTk=";
        };
        target = "${config.homePath}/.config/nvim";
      };

      # Create quick aliases for launching Neovim
      programs.zsh = {
        shellAliases = {
          v = "nvim";
          vim = "nvim";
        };
      };

    };
  };
}
