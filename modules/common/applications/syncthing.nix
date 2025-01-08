{ config, pkgs, lib, ... }: {

  options.syncthing.enable = lib.mkEnableOption "Enable Syncthing.";

  config = lib.mkIf config.syncthing.enable {

    home-manager.users.${config.user} = {

      services.syncthing = {

        enable = true;
        package = pkgs.syncthing;
        guiAddress = "127.0.0.1:8384";

        # Don't override devices and folders added though
        # GUI until I've figured out/ensured all devides
        # are added correctly through Nix configs
        overrideDevices = false;
        overrideFolders = false;

        settings = {

          gui = { theme = "black"; };
          options = { localAnnounceEnabled = false; };

          devices = {
            galaxy-S21 = {
              addresses = [ "tcp://192.168.0.10:51820" ];
              id =
                "7CFNTQM-IMTJBHJ-3UWRDIU-ZGQJFR6-VCXZ3NB-XUH3KZO-N52ITXR-LAIYUAU";
            };
          };

          folders = {
            "~/org" = {
              id = "org";
              devices = [ "galaxyS21" ];
            };
          };

        };

      };

    };

  };

}
