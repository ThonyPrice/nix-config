{ config, pkgs, lib, ... }: {

  options = {
    spotify = {
      enable = lib.mkEnableOption {
        description = "Enable Spotify.";
        default = false;
      };
    };
  };

  config = lib.mkIf
    (config.gui.enable && config.spotify.enable && pkgs.stdenv.isDarwin) {
      unfreePackages = [ "spotify" ];
      home-manager.users.${config.user} = {
        home.packages = with pkgs; [ spotify spicetify-cli ];
      };

    };

}
