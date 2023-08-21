{ config, pkgs, lib, ... }:

{

  config = lib.mkIf pkgs.stdenv.isLinux {

    # Rofi
    environment.systemPackages = with pkgs;
      [
        rofi-wayland
      ];

  };

}
