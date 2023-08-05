{ config, pkgs, lib, ... }: {

  home-manager.users.${config.user} = lib.mkIf pkgs.stdenv.isDarwin {

    home.packages = with pkgs; [ yabai ];

    home.file.yabai = {
      source = ./yabairc;
      target = "${config.homePath}/.config/yabai/yabairc";
      executable = false;
    };

  };

  # TODO: Refactor thin into same cfg as the rest
  services.yabai = {
    enable = true;
    enableScriptingAddition = true;
    extraConfig =
      "sudo -u ${config.user} ${config.homePath}/.config/yabai/yabairc";
  };

}
