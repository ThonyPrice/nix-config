{ config, pkgs, ... }:

let
  home           = builtins.getEnv "HOME";
  xdg_configHome = "${home}/.config";
  xdg_dataHome   = "${home}/.local/share";
  xdg_stateHome  = "${home}/.local/state";
in
{
  k9s = {
    source = ../common/config/k9s/skin.yml;
    target = "${home}/Library/Application Support/k9s/skin.yml";
  };

  sketchybar = {
    source = config/sketchybar;
    target = ".config/sketchybar";
  };

  skhd = {
    source = config/skhdrc;
    target = ".config/skhd/skhdrc";
    executable = false;
  };

  spicetify = {
    source = config/spicetify;
    target = ".spicetify";
    onChange = "${pkgs.spicetify-cli}/bin/spicetify-cli backup apply";
  };

  yabai = {
    source = config/yabairc;
    target = ".config/yabai/yabairc";
    executable = true;
  };

  # Raycast script so that "Run Emacs" is available and uses Emacs daemon
  raycast_emacs = {
    target = "${xdg_dataHome}/bin/emacsclient";
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
      # @raycast.icon ${xdg_dataHome}/img/icons/Emacs.icns
      # @raycast.iconDark ${xdg_dataHome}/img/icons/Emacs.icns

      if [[ $1 = "-t" ]]; then
        # Terminal mode
        ${pkgs.emacs}/bin/emacsclient -t $@
      else
        # GUI mode
        ${pkgs.emacs}/bin/emacsclient -c -n $@
      fi
    '';
  };
}
