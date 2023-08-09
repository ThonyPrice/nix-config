{ config, pkgs, lib, ... }: {

  options.neovim.enable = lib.mkEnableOption "Enable common Emacs";

  config = lib.mkIf config.neovim.enable {
    home-manager.users.${config.user} = {

      home.packages = with pkgs; [
        neovim
        # AstroNvim dependencies
        bottom
        tree-sitter
        lazygit
      ];

      home.sessionVariables = {
        EDITOR = "nvim";
        MANPAGER = "nvim +Man!";
      };

      # Configura Neovim with Astro
      home.file.astroNvim = {
        source = pkgs.fetchFromGitHub {
          owner = "AstroNvim";
          repo = "AstroNvim";
          rev = "43d4581";
          sha256 = "nsUcYhBF0tBY71lFbOLM6TrxK4AF6w+CB5jfEKLB2yk=";
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
