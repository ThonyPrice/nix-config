{ config, pkgs, lib, ... }: {

  config = lib.mkIf pkgs.stdenv.isDarwin {

    fonts.packages = [ pkgs.fira-code-nerdfont ];

    home-manager.users.${config.user} = lib.mkIf pkgs.stdenv.isDarwin {

      home.packages = with pkgs;
        [
          (nerdfonts.override {
            fonts = [ "VictorMono" "JetBrainsMono" "Hack" "FiraCode" "NerdFontsSymbolsOnly" ];
          })
        ];

    };

  };

}
