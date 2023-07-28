{ pkgs, ... }:

{ 
  astroNvim = {
    source = pkgs.fetchFromGitHub {
      owner = "AstroNvim";
      repo = "AstroNvim";
      rev = "43d4581";
      sha256 = "nsUcYhBF0tBY71lFbOLM6TrxK4AF6w+CB5jfEKLB2yk=";
    };
    target = ".config/nvim";
  };

  # doomEmacsConfig = {
  #   source = config/doom;
  #   target = ".doom.d";
  #   onChange = builtins.readFile config/doom-reload.sh;
  # };

}
