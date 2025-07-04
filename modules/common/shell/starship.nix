{ config, pkgs, lib, ... }:

# One of `latte`, `frappe`, `macchiato`, or `mocha`
let flavour = "macchiato";
in {

  home-manager.users.${config.user}.programs.starship = {

    enable = true;

    settings = {
      format = "$all"; # Remove this line to disable the default prompt format
      palette = "catppuccin_${flavour}";
      gcloud = { disabled = true; };
    } // builtins.fromTOML (builtins.readFile (pkgs.fetchFromGitHub {
      owner = "catppuccin";
      repo = "starship";
      rev = "5629d2356f62a9f2f8efad3ff37476c19969bd4f";
      sha256 = "nsRuxQFKbQkyEI4TXgvAjcroVdG+heKX5Pauq/4Ota0=";
    } + /palettes/${flavour}.toml));
  };
}
