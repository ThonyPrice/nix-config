{ config, pkgs, lib, ... }: {

  options.aerospace.enable = lib.mkEnableOption "Aerospace twm";

  config = lib.mkIf (pkgs.stdenv.isDarwin && config.aerospace.enable) {

    # Aerospace is not avilable in nixpkgs and
    # not through nix-darwin. So it's installed with homebrew.
    # Here, we only set the config
    home-manager.users.${config.user} = {

      home.file.aerospace = {
        source = ./aerospace.toml;
        target = "${config.homePath}/.config/aerospace/";
      };

    };

  };

}
