{ config, pkgs, lib, ... }: {

  config = {

    # Define hostname
    networking.hostName = "toto";

    # Enable network manager
    networking.networkmanager.enable = true;

    home-manager.users.${config.user} = {

      services.network-manager-applet.enable = true;

    };

  };

}
