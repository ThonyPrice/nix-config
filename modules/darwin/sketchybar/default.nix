{ config, pkgs, lib, ... }: {

  config = lib.mkIf pkgs.stdenv.isDarwin {

    # Enable Sketchybar service
    services.sketchybar = {
      # enable = true;
      package = pkgs.sketchybar;
      config = ''
        source ${config.homePath}/.config/sketchybar/sketchybarrc
      '';
      extraPackages = [ pkgs.gh ];
    };

    # Manage Sketchybar config directory
    home-manager.users.${config.user} = {

      home.packages = with pkgs; [
        # Opt to install  package and start from wm init,
        # strange issues appeared when starting enable the service aboove.
        sketchybar
        gh
      ];

      home.file.sketchybar = {
        source = ./config;
        target = "${config.homePath}/.config/sketchybar";
      };

    };

  };

}
