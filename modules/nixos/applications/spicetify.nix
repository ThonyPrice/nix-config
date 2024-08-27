{ config, pkgs, lib, inputs, ... }:

let spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};

in {

  config = lib.mkIf
    (config.gui.enable && config.spotify.enable && pkgs.stdenv.isLinux) {

      home-manager.users.${config.user} = {

        imports = [ inputs.spicetify-nix.homeManagerModules.default ];

        programs.spicetify = {
          enable = true;
          theme = spicePkgs.themes.catppuccin;
          colorScheme = "macchiato";

          enabledExtensions = with spicePkgs.extensions; [
            fullAppDisplay
            shuffle # shuffle+ (special characters are sanitized out of ext names)
            hidePodcasts
          ];

        };

      };

    };

}
