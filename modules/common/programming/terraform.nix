{ config, pkgs, lib, ... }: {

  options.terraform.enable = lib.mkEnableOption "Terraform tools.";

  config = lib.mkIf config.terraform.enable {

    home-manager.users.${config.user} = {

      home.packages = with pkgs; [
        terraform # Terraform executable
        terragrunt # State support
        tflint # Linter
      ];

    };

  };

}
