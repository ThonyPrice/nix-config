{ config, pkgs, lib, ... }:

{

  unfreePackages = [ "_1password-cli" ];
  home-manager.users.${config.user} = lib.mkIf pkgs.stdenv.isDarwin {

    home.packages = with pkgs; [
      # visidata # CSV inspector
      _1password-cli
      zx
      coreutils
      dockutil
      # ansible
      vault
      samba
      (writeShellApplication {
        name = "ocr";
        runtimeInputs = [ tesseract ];
        text = builtins.readFile ../../modules/common/shell/bash/scripts/ocr.sh;
      })
    ];

  };

}
