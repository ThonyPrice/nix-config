{ config, pkgs, lib, ... }:

{

  config = lib.mkIf pkgs.stdenv.isLinux {

    home-manager.users.${config.user} = {

      programs.rofi = {
        enable = true;
        cycle = true;
        location = "center";
        font = "Fira Code Font 11";
        package = pkgs.rofi-wayland;
        plugins = [ pkgs.rofi-calc pkgs.rofi-emoji ];
        extraConfig = {
          show-icons = true;
          kb-cancel = "Escape,Super+space";
          modi = "window,run,ssh,emoji,calc";
          sort = true;
        };
        theme = let
          inherit (config.home-manager.users.${config.user}.lib.formats.rasi)
            mkLiteral;
        in {
          "*" = {
            background-color = mkLiteral "#1e1e2e";
            foreground-color = mkLiteral "#cdd6f4";
            border-color = mkLiteral "#1e1e2e";
            selected-color = mkLiteral "#1e1e2e";
            width = 360;
          };
        };

      };

    };

  };

}
