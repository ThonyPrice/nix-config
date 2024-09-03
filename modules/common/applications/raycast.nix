{ config, pkgs, lib, ... }: {

  options = {
    raycast = {
      enable = lib.mkEnableOption {
        description = "Enable Raycast.";
        default = false;
      };
    };
  };

  config = lib.mkIf (config.gui.enable && config.raycast.enable) {
    unfreePackages = [ "raycast" ];
    home-manager.users.${config.user} = {
      home.packages = with pkgs; [ raycast ];

      # Raycast script so that "Run Emacs" is available and uses Emacs daemon
      home.file.raycast_run_emacs = {
        target = "${config.homePath}/.local/share/raycast/emacsclient";
        executable = true;
        text = ''
          #!/bin/zsh
          #
          # Required parameters:
          # @raycast.schemaVersion 1
          # @raycast.title Run Emacs
          # @raycast.mode silent
          #
          # Optional parameters:
          # @raycast.packageName Emacs
          # @raycast.icon ${config.homePath}/img/icons/Emacs.icns
          # @raycast.iconDark ${config.homePath}/img/icons/Emacs.icns

          if [[ $1 = "-t" ]]; then
            # Terminal mode
            ${pkgs.emacs-unstable}/bin/emacsclient -t $@
          else
            # GUI mode
            ${pkgs.emacs-unstable}/bin/emacsclient -c -n $@
          fi
        '';
      };

      # Raycast script to launch Kitty, "Run Emacs"
      home.file.raycast_run_kitty = {
        target = "${config.homePath}/.local/share/raycast/runkitty";
        executable = true;
        text = ''
          #!/bin/zsh
          #
          # Required parameters:
          # @raycast.schemaVersion 1
          # @raycast.title Run Kitty
          # @raycast.mode silent
          #
          # Optional parameters:
          # @raycast.packageName Kitty
          # @raycast.icon ${config.homePath}/img/icons/Kitty.icns
          # @raycast.iconDark ${config.homePath}/img/icons/Kitty.icns

          ${pkgs.kitty}/bin/kitty --single-instance -d ~ $@
        '';
      };

    };

  };

}
