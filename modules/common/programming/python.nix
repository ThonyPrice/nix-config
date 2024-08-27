{ config, pkgs, lib, ... }: {

  options.python.enable = lib.mkEnableOption "Python programming language.";

  config = lib.mkIf config.python.enable {

    home-manager.users.${config.user} = {

      home.packages = with pkgs; [
        python311 # Standard Python interpreter
        python311Packages.flake8 # Python linter
        python311Packages.pip # Python package manager
        poetry # Python dependency manager
        black # Python formatter
        nodePackages.pyright # Python language server
        openssl
      ];

      programs.zsh.shellAliases = { py = "python3"; };

    };

  };

}
