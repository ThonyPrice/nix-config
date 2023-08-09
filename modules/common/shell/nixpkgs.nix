{ config, pkgs, ... }: {
  home-manager.users.${config.user} = {

    # Provides "command-not-found" options
    programs.nix-index = {
      enable = true;
      enableZshIntegration = true;
    };

  };

  nix = {

    # Set channel to flake packages, used for nix-shell commands
    nixPath = [ "nixpkgs=${pkgs.path}" ];

    # Set registry to this flake's packages, used for nix X commands
    registry.nixpkgs.to = {
      type = "path";
      path = builtins.toString pkgs.path;
    };

    # For security, only allow specific users
    # settings.allowed-users = [ "@admin" config.user ];
    settings.trusted-users = [ "@admin" "${config.user}" ];

  };

}
