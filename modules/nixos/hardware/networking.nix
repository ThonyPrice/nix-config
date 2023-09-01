{ config, pkgs, lib, ... }: {

  config = {

    # Define hostname
    networking.hostName = "toto";

    # Enable network manager
    networking.networkmanager.enable = true;

  };

}
