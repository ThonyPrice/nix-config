{ config, pkgs, lib, ... }: {

  options.ai.enable = lib.mkEnableOption "AI tools.";

  config = lib.mkIf config.terraform.enable {
    unfreePackages = [ "claude-code" ];
    home-manager.users.${config.user} = {

      home.packages = with pkgs; [ claude-code aider-chat task-master-ai ];

    };

  };

}
