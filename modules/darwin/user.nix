{ config, pkgs, lib, ... }: {

  config = lib.mkIf pkgs.stdenv.isDarwin {

    users.users."${config.user}" = {
      # macOS user
      name = "${config.user}";
      home = config.homePath;
      isHidden = false;
    };

    # Used for aerc
    home-manager.users.${config.user} = {
      home.sessionVariables = {
        XDG_CONFIG_HOME = "${config.homePath}/.config";
      };
    };

  };

}
