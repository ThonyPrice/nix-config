{ config, pkgs, lib, ... }: {

  options = {
    firefox = {
      enable = lib.mkEnableOption {
        description = "Enable Firefox.";
        default = false;
      };
    };
  };

  config = lib.mkIf
    (config.gui.enable && config.firefox.enable && pkgs.stdenv.isLinux) {
      unfreePackages = [ "1password" "_1password-gui" ];
      home-manager.users.${config.user} = {
        home.packages = with pkgs; [ firefox ];
    };
    
  };

}


