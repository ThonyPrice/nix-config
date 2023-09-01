{ config, pkgs, lib, ... }:


{

  config = lib.mkIf (pkgs.stdenv.isLinux && config.gui.enable) {

    hardware.bluetooth.enable = true;
    services.blueman.enable = true;

  };

}
