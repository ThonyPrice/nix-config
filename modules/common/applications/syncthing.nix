{ config, pkgs, lib, ... }: {

  options.syncthing.enable = lib.mkEnableOption "Enable Syncthing.";

  config = lib.mkIf config.syncthing.enable {

    home-manager.users.${config.user} = {

      services.syncthing = {

        enable = true;
        package = pkgs.syncthing;
        guiAddress = "127.0.0.1:8384";

        overrideFolders = false;
        overrideDevices = false;

        settings = {

          gui = { theme = "black"; };
          options = { localAnnounceEnabled = false; };

          devices = {
            galaxyS21 = {
              id =
                "IT4OBHL-7AXGSL3-VBW7RTJ-K64NJTW-UA5VWTI-UEUCGWF-Z6XZJXP-RZM65Q4";
            };
          };

          folders = {
            "~/git/org" = {
              id = "org";
              devices = [ "galaxyS21" ];
            };
            "~/Sync" = {
              id = "sync";
              devices = [ ];
            };
          };

        };

      };

    };

  };

}
