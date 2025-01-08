{ config, pkgs, lib, ... }: {

  config = lib.mkIf pkgs.stdenv.isDarwin {
    networking = {
      computerName = "${config.fullName}''' Mac";
      # Adjust if necessary
      # hostName = "";
    };
  };

}
