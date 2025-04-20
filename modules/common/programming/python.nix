{ config, pkgs, lib, ... }: {

  options.python.enable = lib.mkEnableOption "Python programming language.";

  config = lib.mkIf config.python.enable {

    home-manager.users.${config.user} = {

      home.packages = with pkgs; [
        python312 # Standard Python interpreter
        python312Packages.flake8 # Python linter
        python312Packages.pip # Python package manager
        poetry # Python dependency manager
        black # Python formatter
        pyright # Python language server
        openssl
      ];

      programs.zsh.shellAliases = { py = "python3"; };

    };

  };

}
