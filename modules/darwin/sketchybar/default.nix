{ config, pkgs, lib, ... }: {

  config = lib.mkIf pkgs.stdenv.isDarwin {

    # Enable Sketchybar service
    services.sketchybar = { 
      enable = true; 
      package = pkgs.sketchybar;
      config = ''
        source ${config.homePath}/.config/sketchybar/sketchybarrc
      '';
      extraPackages = [ pkgs.gh ];
    };

    # Manage Sketchybar config directory
    home-manager.users.${config.user} = {

      home.file.sketchybar = {
        source = ./config;
        target = "${config.homePath}/.config/sketchybar";
      };

    };

  };


}
