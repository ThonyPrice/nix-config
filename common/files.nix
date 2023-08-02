{ pkgs, ... }:

let
  home           = builtins.getEnv "HOME";
  xdg_configHome = "${home}/.config";
  xdg_dataHome   = "${home}/.local/share";
  xdg_stateHome  = "${home}/.local/state";
in
{
  bat = {
    source = config/bat;
    target = ".config/bat";
  };

  astroNvim = {
    source = pkgs.fetchFromGitHub {
      owner = "AstroNvim";
      repo = "AstroNvim";
      rev = "43d4581";
      sha256 = "nsUcYhBF0tBY71lFbOLM6TrxK4AF6w+CB5jfEKLB2yk=";
    };
    target = "${home}/.config/nvim";
  };

  kitty = {
    source = config/kitty;
    target = ".config/kitty";
  };
}
