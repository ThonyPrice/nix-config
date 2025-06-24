{ config, pkgs, lib, ... }:

{

  unfreePackages = [ "arc-browser" ];
  home-manager.users.${config.user} = lib.mkIf pkgs.stdenv.isDarwin {
    home.packages = with pkgs;
      [
        # Since there's no Nix package for firefox on MacOS :(
        arc-browser
      ];

  };

}
