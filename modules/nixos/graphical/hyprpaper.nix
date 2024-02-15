{ config, lib, pkgs, ... }: {

  options.hyprpaper.enable = lib.mkEnableOption "Enable Wallpapers setup";

  config = lib.mkIf (pkgs.stdenv.isLinux && config.hyprpaper.enable) {

    home-manager.users.${config.user} = {

      home.packages = with pkgs; [ hyprpaper ];

      home.file.hyprpaper = {
        target = "${config.homePath}/.config/hypr/hyprpaper.conf";
        text = ''
          preload = ~/git/wps/wallpaper.jpg
          wallpaper = eDP-1,~/git/wps/wallpaper.jpg
        '';
      };

    };

  };

}
