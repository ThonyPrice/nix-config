{ pkgs, ... }:

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
    target = ".config/nvim";
  };

  kitty = {
    source = config/kitty;
    target = ".config/kitty";
  };
}
