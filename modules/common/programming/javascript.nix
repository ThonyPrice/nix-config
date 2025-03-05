{ config, pkgs, lib, ... }: {

  options.javascript.enable =
    lib.mkEnableOption "JavaScript/TypeScript and utils.";

  config = lib.mkIf config.javascript.enable {

    home-manager.users.${config.user} = {

      home.packages = with pkgs; [ nodejs_20 nodePackages.pnpm ];

    };

  };

}
