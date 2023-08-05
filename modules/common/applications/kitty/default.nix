{ config, pkgs, lib, ... }: {

  options = {
    kitty = {
      enable = lib.mkEnableOption {
        description = "Enable Kitty.";
        default = false;
      };
    };
  };

  config = lib.mkIf (config.gui.enable && config.kitty.enable) {

    # Set the Rofi-Systemd terminal for viewing logs
    # Using optionalAttrs because only available in NixOS
    environment = { } // lib.attrsets.optionalAttrs
      (builtins.hasAttr "sessionVariables" config.environment) {
        sessionVariables.ROFI_SYSTEMD_TERM = "${pkgs.kitty}/bin/kitty";
      };

    home-manager.users.${config.user} = {

      # Set the i3 terminal
      xsession.windowManager.i3.config.terminal =
        lib.mkIf pkgs.stdenv.isLinux "kitty";

      # Set the Rofi terminal for running programs
      programs.rofi.terminal =
        lib.mkIf pkgs.stdenv.isLinux "${pkgs.kitty}/bin/kitty";

      # Display images in the terminal
      programs.zsh.shellAliases = {
        icat = "kitty +kitten icat";
        ssh = "kitty +kitten ssh";
      };

      programs.kitty = {
        enable = true;
        extraConfig = (builtins.readFile ./kitty.conf);
      };
    };
  };
}
