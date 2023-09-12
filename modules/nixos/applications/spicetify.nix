{ config, pkgs, lib, inputs, ... }:

let spicePkgs = inputs.spicetify-nix.packages.${pkgs.system}.default;

in {

  config = lib.mkIf
    (config.gui.enable && config.spotify.enable && pkgs.stdenv.isLinux) {

      home-manager.users.${config.user} = {

        imports = [ inputs.spicetify-nix.homeManagerModule ];

        programs.spicetify = {
          enable = true;
          theme = spicePkgs.themes.catppuccin-macchiato;
          colorScheme = "flamingo";

          enabledExtensions = with spicePkgs.extensions; [
            fullAppDisplay
            shuffle # shuffle+ (special characters are sanitized out of ext names)
            hidePodcasts
          ];

        };

      };

    };

}
