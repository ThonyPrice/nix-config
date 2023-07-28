{ config, pkgs, ... }:

let
  home           = builtins.getEnv "HOME";
  xdg_configHome = "${home}/.config";
  xdg_dataHome   = "${home}/.local/share";
  xdg_stateHome  = "${home}/.local/state"; in
{
  sketchybar = {
    source = config/sketchybar;
    target = ".config/sketchybar";
  };

  skhd = {
    source = config/skhdrc;
    target = ".config/skhd/skhdrc";
    executable = false;
  };

  yabai = {
    source = config/yabairc;
    target = ".config/yabai/yabairc";
    executable = true;
  };
}
