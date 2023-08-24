{ config, pkgs, lib, ... }: {

  options.vscode.enable = lib.mkEnableOption "Enable VSCode";

  config = lib.mkIf config.vscode.enable {
    unfreePackages = [ "vscode" ];
    home-manager.users.${config.user} = {

      programs.vscode = {
        enable = true;
        package = pkgs.vscodium;

      };

    };

  };

}
