{ config, pkgs, lib, ... }: {

  options.chromium.enable = lib.mkEnableOption "Enable Chromium.";

  config = lib.mkIf (config.gui.enable && config.chromium.enable) {
    unfreePackages = [ "chromium" ];
    home-manager.users.${config.user} = {

      programs.chromium = {
        enable = true;
        package = pkgs.chromium;
        extensions = [

          { # ublock origin
            id = "cjpalhdlnbpafiamejdnhcphjbkeiagm";
          }
          { # Endpoint Verification
            id = "callobklhcbilhphinckomhgkigmfocg";
          }
          { # 1Password
            id = "aeblfdkhhhdcdjpifhhbdiojplfjncoa";
          }

        ];

      };

    };

  };

}
