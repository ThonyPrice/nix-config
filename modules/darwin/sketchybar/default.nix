{ config, pkgs, lib, ... }: {

  home-manager.users.${config.user} = lib.mkIf pkgs.stdenv.isDarwin {

    home.packages = with pkgs; [ sketchybar gh ];

    home.file.sketchybar = {
      source = ./config;
      target = "${config.homePath}/.config/sketchybar";
    };

  };

  # TODO: Refactor thin into same cfg as the rest
  services.sketchybar = { enable = true; };

}
