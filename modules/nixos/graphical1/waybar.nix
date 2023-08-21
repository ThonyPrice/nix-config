{ config, pkgs, lib, ... }:

let

  var = "Hello";

in {

  config = lib.mkIf pkgs.stdenv.isLinux {

    # Hyprland itself
    # programs.hyperland = {
    #   enable = true;
    #   package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    # };

    # Waybar
    programs.waybar = {
      enable = true;
      package = pkgs.waybar.overrideAttrs (oldAttrs: {
        mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
      });
    };
 
    environment.systemPackages = [
      pkgs.swayosd
    ];

    home-manager.users.${config.user} = {};

  };

}
