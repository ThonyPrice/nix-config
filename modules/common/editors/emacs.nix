{ config, pkgs, lib, ... }: {

  options.emacs.enable = lib.mkEnableOption "Enable common Emacs";

  config = lib.mkIf config.emacs.enable {

    environment.systemPackages = with pkgs; [
      # Installs Emacs 28 + native-comp
      pkgs.emacs-unstable
    ];

    home-manager.users.${config.user} = {

      home.packages = with pkgs; [
        # Doom Emacs dependencied
        clang
        cmake
        coreutils
        emacs-all-the-icons-fonts
        fd
        gnutls
        ripgrep
      ];

      # Create quick aliases for launching Emacs
      programs.zsh = {
        shellAliases = {
          e = "emacsclient -t $@";
        };
      };

    };

  };

}
