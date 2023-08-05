{ config, pkgs, lib, ... }:

{

  home-manager.users.${config.user} = lib.mkIf pkgs.stdenv.isDarwin {

    home.packages = with pkgs; [
      # visidata # CSV inspector
      #
      coreutils
      dockutil
      google-cloud-sdk
      ansible
      vault
      (writeShellApplication {
        name = "ocr";
        runtimeInputs = [ tesseract ];
        text = builtins.readFile ../../modules/common/shell/bash/scripts/ocr.sh;
      })
    ];

  };

}
