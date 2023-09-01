{ config, pkgs, lib, ... }:


{

  config = lib.mkIf pkgs.stdenv.isLinux {

    # Enable the X11 windowing system with Wayland.
    # services.xserver = {
    #   enable = true;
    #   displayManager.gdm = {
    #     enable = true;
    #     wayland = true;
    #   };
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
    
    # Fix permissions to edit backligt
    services.udev.extraRules = ''
      ACTION=="add", SUBSYSTEM=="backlight", KERNEL=="intel_backlight", MODE="0666", RUN+="${pkgs.coreutils}/bin/chmod a+w /sys/class/backlight/%k/brightness"
    '';

    home-manager.users.${config.user} = {};

  };

}
