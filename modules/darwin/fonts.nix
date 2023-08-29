{ config, pkgs, lib, ... }: {

  home-manager.users.${config.user} = lib.mkIf pkgs.stdenv.isDarwin {

    home.packages = with pkgs;
      [
        (nerdfonts.override {
          fonts = [ "VictorMono" "JetBrainsMono" "Hack" "FiraCode" ];
        })
      ];

  };

}
