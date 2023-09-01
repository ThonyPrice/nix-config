{ config, pkgs, lib, ... }:
  
{
  
  config = lib.mkIf pkgs.stdenv.isLinux {
  
    environment.systemPackages = with pkgs; [
      feh # Wallpaper
      networkmanagerapplet # Network manager GUI
    ];
  
    home-manager.users.${config.user} = {};

  };
  
}
